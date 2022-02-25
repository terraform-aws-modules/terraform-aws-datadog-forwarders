locals {
  dd_api_key            = var.dd_api_key != "" ? { DD_API_KEY = var.dd_api_key } : {}
  dd_api_key_secret_arn = var.dd_api_key_secret_arn != "" ? { DD_API_KEY_SECRET_ARN = var.dd_api_key_secret_arn } : {}

  description = "Lambda function to push RDS Enhanced metrics to Datadog"
  version_tag = { DD_FORWARDER_VERSION = var.forwarder_version }

  role_name   = coalesce(var.role_name, var.name)
  policy_name = coalesce(var.policy_name, var.name)
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
      vpc_check             = var.subnet_ids != null
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
      local.dd_api_key,
      local.dd_api_key_secret_arn,
      {
        DD_SITE = var.dd_site
      },
      var.environment_variables,
      local.version_tag
    )
  }

  tags = merge(var.tags, var.lambda_tags, local.version_tag)
}

resource "aws_lambda_permission" "cloudwatch" {
  count = var.create ? 1 : 0

  statement_id  = "datadog-forwarder-RDSCloudWatchLogsPermission"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this[0].function_name
  principal     = "logs.amazonaws.com"
  source_arn    = "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:RDSOSMetrics:*"
}

resource "aws_cloudwatch_log_group" "this" {
  count = var.create ? 1 : 0

  name              = "/aws/lambda/${aws_lambda_function.this[0].function_name}"
  retention_in_days = var.log_retention_days

  tags = var.tags
}
