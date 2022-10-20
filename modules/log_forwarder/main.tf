locals {
  bucket_name = var.bucket_name != "" ? var.bucket_name : "datadog-forwarder-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"

  dd_api_key            = var.dd_api_key != "" ? { DD_API_KEY = var.dd_api_key } : {}
  dd_api_key_secret_arn = var.dd_api_key_secret_arn != "" ? { DD_API_KEY_SECRET_ARN = var.dd_api_key_secret_arn } : {}

  description = "Lambda function to push logs, metrics, and traces to Datadog"
  version_tag = { DD_FORWARDER_VERSION = var.forwarder_version }

  role_name   = coalesce(var.role_name, var.name)
  policy_name = coalesce(var.policy_name, var.name)

  zip_url       = "https://github.com/DataDog/datadog-serverless-functions/releases/download/aws-dd-forwarder-${var.forwarder_version}/aws-dd-forwarder-${var.forwarder_version}.zip"
  zip_name      = "aws-dd-forwarder-${var.forwarder_version}.zip"
  forwarder_zip = "${path.module}/${local.zip_name}"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

################################################################################
# Forwarder Bucket
################################################################################

module " aws_s3_object" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "v3.0.1"

  create_bucket = var.create && var.create_bucket
  bucket        = local.bucket_name
  force_destroy = true

  attach_deny_insecure_transport_policy = var.bucket_attach_deny_insecure_transport_policy

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  versioning = {
    enabled = true
  }

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = var.bucket_encryption_settings
    }
  }

  tags = var.tags
}

################################################################################
# Forwarder IAM Role
################################################################################

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "this" {
  count = var.create && var.create_role ? 1 : 0

  name        = var.use_role_name_prefix ? null : local.role_name
  name_prefix = var.use_role_name_prefix ? "${local.role_name}-" : null
  description = local.description
  path        = var.role_path

  assume_role_policy    = data.aws_iam_policy_document.this.json
  max_session_duration  = var.role_max_session_duration
  permissions_boundary  = var.role_permissions_boundary
  force_detach_policies = true

  tags = merge(var.tags, var.role_tags)
}

resource "aws_iam_policy" "this" {
  count = var.create && var.create_role_policy ? 1 : 0

  name        = var.use_policy_name_prefix ? null : local.policy_name
  name_prefix = var.use_policy_name_prefix ? "${local.policy_name}-" : null
  description = local.description
  path        = var.policy_path

  policy = templatefile(
    "${path.module}/policy.tmpl",
    {
      vpc_check             = var.subnet_ids != null
      s3_check              = length(var.s3_log_bucket_arns) > 0
      s3_log_bucket_arns    = jsonencode(var.s3_log_bucket_arns)
      datadog_s3_bucket     = "arn:aws:s3:::${local.bucket_name}"
      dd_api_key_secret_arn = var.dd_api_key_secret_arn
    }
  )

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  count = var.create && var.create_role ? 1 : 0

  role       = aws_iam_role.this[0].id
  policy_arn = var.create_role_policy ? aws_iam_policy.this[0].id : var.policy_arn
}

################################################################################
# Forwarder Lambda Function
################################################################################

resource "null_resource" "this" {
  count = var.create ? 1 : 0

  triggers = {
    on_version_change = var.forwarder_version
  }

  provisioner "local-exec" {
    command = "curl --silent -o ${local.forwarder_zip} -L '${local.zip_url}'"
  }
}

resource "aws_s3_bucket_object" "this" {
  count = var.create ? 1 : 0

  bucket = var.create_bucket ? module.this_s3_bucket.s3_bucket_id : var.bucket_name
  key    = join("/", compact([var.bucket_prefix, local.zip_name]))
  source = local.forwarder_zip

  content_encoding = "zip"
  content_language = "en-US"
  content_type     = "application/zip"

  storage_class          = var.s3_zip_storage_class
  server_side_encryption = var.s3_zip_server_side_encryption
  kms_key_id             = var.s3_zip_kms_key_id
  metadata               = var.s3_zip_metadata

  tags = merge(var.tags, var.s3_zip_tags, local.version_tag)

  depends_on = [null_resource.this]
}

resource "aws_lambda_function" "this" {
  count = var.create ? 1 : 0

  s3_bucket         = var.create_bucket ? module.this_s3_bucket.s3_bucket_id : var.bucket_name
  s3_key            = aws_s3_bucket_object.this[0].key
  s3_object_version = aws_s3_bucket_object.this[0].version_id
  function_name     = var.name
  handler           = "lambda_function.lambda_handler"

  role          = var.create_role ? aws_iam_role.this[0].arn : var.role_arn
  description   = local.description
  runtime       = var.runtime
  layers        = var.layers
  memory_size   = var.memory_size
  timeout       = var.timeout
  publish       = var.publish
  architectures = var.architectures

  reserved_concurrent_executions = var.reserved_concurrent_executions
  kms_key_arn                    = var.kms_key_arn


  dynamic "vpc_config" {
    for_each = var.subnet_ids != null && var.security_group_ids != null ? [true] : []
    content {
      security_group_ids = var.security_group_ids
      subnet_ids         = var.subnet_ids
    }
  }

  environment {
    variables = merge(
      local.dd_api_key,
      local.dd_api_key_secret_arn,
      {
        DD_ENHANCED_METRICS       = false
        DD_FETCH_LAMBDA_TAGS      = true
        DD_TAGS_CACHE_TTL_SECONDS = 300
        DD_USE_PRIVATE_LINK       = false
        DD_SITE                   = var.dd_site
        DD_S3_BUCKET_NAME         = local.bucket_name
      },
      var.environment_variables,
      local.version_tag
    )
  }

  tags = merge(var.tags, var.lambda_tags, local.version_tag)
}

resource "aws_lambda_permission" "cloudwatch" {
  count = var.create ? 1 : 0

  statement_id   = "datadog-forwarder-CloudWatchLogsPermission"
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.this[0].function_name
  principal      = "logs.${data.aws_region.current.name}.amazonaws.com"
  source_account = data.aws_caller_identity.current.account_id
}

resource "aws_lambda_permission" "s3" {
  count = var.create && length(var.s3_log_bucket_arns) > 0 ? 1 : 0

  statement_id   = "datadog-forwarder-S3Permission"
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.this[0].function_name
  principal      = "s3.amazonaws.com"
  source_account = data.aws_caller_identity.current.account_id
}

resource "aws_cloudwatch_log_group" "this" {
  count = var.create ? 1 : 0

  name              = "/aws/lambda/${aws_lambda_function.this[0].function_name}"
  retention_in_days = var.log_retention_days

  tags = var.tags
}
