locals {
  description = "Lambda function to push VPC flow log metrics to Datadog"
  version_tag = { DD_FORWARDER_VERSION = var.forwarder_version }

  role_name   = coalesce(var.role_name, var.name)
  policy_name = coalesce(var.policy_name, var.name)

  dd_api_key  = try(data.aws_secretsmanager_secret_version.datadog_api_key[0].secret_string, "")
  api_app_key = <<EOF
{"api_key":"${local.dd_api_key}", "app_key":"${var.dd_app_key}"}
EOF

  api_key = <<EOF
{"api_key":"${local.dd_api_key}"}
EOF
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

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
      vpc_check          = var.subnet_ids != null
      s3_check           = length(var.s3_log_bucket_arns) > 0
      s3_log_bucket_arns = jsonencode(var.s3_log_bucket_arns)
      kms_arn            = data.aws_kms_key.this[0].arn
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

resource "aws_lambda_function" "this" {
  count = var.create ? 1 : 0

  filename      = "${path.module}/vendored_archives/${var.forwarder_version}.zip"
  function_name = var.name
  handler       = "lambda_function.lambda_handler"

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
      {
        DD_SITE          = var.dd_site
        kmsEncryptedKeys = aws_kms_ciphertext.this[0].ciphertext_blob
      },
      var.environment_variables,
      local.version_tag
    )
  }

  tags = merge(var.tags, var.lambda_tags, local.version_tag)
}

resource "aws_lambda_permission" "cloudwatch" {
  count = var.create && var.read_cloudwatch_logs ? 1 : 0

  statement_id   = "datadog-forwarder-CloudWatchLogsPermission"
  action         = "lambda:InvokeFunction"
  function_name  = aws_lambda_function.this[0].function_name
  principal      = "logs.${data.aws_region.current.region}.amazonaws.com"
  source_account = data.aws_caller_identity.current.account_id
}

resource "aws_lambda_permission" "s3" {
  count = var.create && var.s3_log_bucket_arns != [] ? 1 : 0

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
  kms_key_id        = var.log_kms_key_id

  tags = var.tags
}

data "aws_kms_key" "this" {
  count = var.create ? 1 : 0

  key_id = var.kms_alias
}

data "aws_secretsmanager_secret_version" "datadog_api_key" {
  count = var.create ? 1 : 0

  secret_id = var.dd_api_key_secret_arn
}

resource "aws_kms_ciphertext" "this" {
  count = var.create ? 1 : 0

  key_id    = data.aws_kms_key.this[0].id
  plaintext = var.dd_app_key != "" ? local.api_app_key : local.api_key
  context   = { LambdaFunctionName = var.name }
}
