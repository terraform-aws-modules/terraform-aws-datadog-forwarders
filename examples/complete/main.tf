provider "aws" {
  region = local.region
}

data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}

locals {
  region = "us-east-1"
  name   = "datadog-fwd-ex-${basename(path.cwd)}"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-datadog-forwarders"
    GithubOrg  = "terraform-aws-modules"
  }
}

# Note: you will need to create this secret manually prior to running
# This avoids having to pass the key to Terraform in plaintext
data "aws_secretsmanager_secret" "datadog_api_key" {
  name = "datadog/api_key"
}

################################################################################
# Module
################################################################################

module "default" {
  source = "../../"

  kms_alias             = aws_kms_alias.datadog.name
  dd_api_key_secret_arn = data.aws_secretsmanager_secret.datadog_api_key.arn
  dd_app_key            = "xxx"

  create_log_forwarder    = true
  create_rds_em_forwarder = true
  create_vpc_fl_forwarder = true

  log_forwarder_name                           = "complete-datadog-log-forwarder"
  create_log_forwarder_role_policy             = false
  log_forwarder_policy_arn                     = aws_iam_policy.custom.arn
  log_forwarder_memory_size                    = 512
  log_forwarder_timeout                        = 60
  log_forwarder_publish                        = true
  log_forwarder_architectures                  = ["arm64"]
  log_forwarder_reserved_concurrent_executions = 10
  log_forwarder_kms_key_arn                    = aws_kms_alias.datadog.target_key_arn
  log_forwarder_subnet_ids                     = module.vpc.private_subnets
  log_forwarder_security_group_ids             = [module.security_group.security_group_id]
  log_forwarder_environment_variables = {
    REDACT_IP                     = true
    REDACT_EMAIL                  = true
    DD_USE_PRIVATE_LINK           = true
    DD_FETCH_LAMBDA_TAGS          = false # required when using privatelink
    DD_SCRUBBING_RULE             = file("${path.module}/pattern.txt")
    DD_SCRUBBING_RULE_REPLACEMENT = "[redacted]"
    DD_URL                        = "api-pvtlink.logs.datadoghq.com" # log forwarder
  }
  log_forwarder_lambda_tags                   = { LogForwarderLambda = true }
  log_forwarder_log_kms_key_id                = aws_kms_alias.datadog.target_key_arn
  log_forwarder_log_retention_days            = 3
  log_forwarder_bucket_prefix                 = "logforwarder"
  log_forwarder_s3_zip_server_side_encryption = "AES256"
  log_forwarder_s3_zip_metadata               = { "alt-name" = "log-forwarder" }
  log_forwarder_s3_zip_tags                   = { LogForwarderZip = true }
  log_forwarder_use_role_name_prefix          = true
  log_forwarder_role_path                     = "/datadog/"
  log_forwarder_role_max_session_duration     = 3900
  log_forwarder_role_tags                     = { ForwarderRole = true }
  log_forwarder_s3_log_bucket_arns            = [module.log_bucket_1.s3_bucket_arn, module.log_bucket_2.s3_bucket_arn]
  log_forwarder_tags                          = { LogForwarder = true }

  rds_em_forwarder_name                           = "complete-datadog-rds-forwarder"
  rds_em_forwarder_memory_size                    = 512
  rds_em_forwarder_timeout                        = 60
  rds_em_forwarder_publish                        = true
  rds_em_forwarder_architectures                  = ["arm64"]
  rds_em_forwarder_reserved_concurrent_executions = 10
  rds_em_forwarder_kms_key_arn                    = aws_kms_alias.datadog.target_key_arn
  rds_em_forwarder_subnet_ids                     = module.vpc.private_subnets
  rds_em_forwarder_security_group_ids             = [module.security_group.security_group_id]
  rds_em_forwarder_environment_variables          = {}
  rds_em_forwarder_lambda_tags                    = { RdsForwarderLambda = true }
  rds_em_forwarder_log_kms_key_id                 = aws_kms_alias.datadog.target_key_arn
  rds_em_forwarder_log_retention_days             = 3
  rds_em_forwarder_use_role_name_prefix           = true
  rds_em_forwarder_role_path                      = "/datadog/"
  rds_em_forwarder_role_max_session_duration      = 3900
  rds_em_forwarder_role_tags                      = { ForwarderRole = true }
  rds_em_forwarder_use_policy_name_prefix         = true
  rds_em_forwarder_policy_path                    = "/datadog/"
  rds_em_forwarder_tags                           = { RdsForwarder = true }

  vpc_fl_forwarder_name                           = "complete-datadog-vpc-forwarder"
  vpc_fl_forwarder_memory_size                    = 512
  vpc_fl_forwarder_timeout                        = 60
  vpc_fl_forwarder_publish                        = true
  vpc_fl_forwarder_architectures                  = ["arm64"]
  vpc_fl_forwarder_reserved_concurrent_executions = 10
  vpc_fl_forwarder_kms_key_arn                    = aws_kms_alias.datadog.target_key_arn
  vpc_fl_forwarder_subnet_ids                     = module.vpc.private_subnets
  vpc_fl_forwarder_security_group_ids             = [module.security_group.security_group_id]
  vpc_fl_forwarder_environment_variables          = {}
  vpc_fl_forwarder_lambda_tags                    = { VpcForwarderLambda = true }
  vpc_fl_forwarder_log_kms_key_id                 = aws_kms_alias.datadog.target_key_arn
  vpc_fl_forwarder_log_retention_days             = 3
  vpc_fl_forwarder_use_role_name_prefix           = true
  vpc_fl_forwarder_role_path                      = "/datadog/"
  vpc_fl_forwarder_role_max_session_duration      = 3900
  vpc_fl_forwarder_role_tags                      = { ForwarderRole = true }
  vpc_fl_forwarder_use_policy_name_prefix         = true
  vpc_fl_forwarder_policy_path                    = "/datadog/"
  vpc_fl_forwarder_tags                           = { VpcForwarder = true }

  vpc_id = module.vpc.vpc_id

  create_metrics_vpce             = true
  metrics_vpce_subnet_ids         = module.vpc.private_subnets
  metrics_vpce_security_group_ids = [module.security_group.security_group_id]
  metrics_vpce_tags               = { MetricsVpcEndpoint = true }

  create_agent_vpce             = true
  agent_vpce_subnet_ids         = module.vpc.private_subnets
  agent_vpce_security_group_ids = [module.security_group.security_group_id]
  agent_vpce_tags               = { AgentVpcEndpoint = true }

  create_log_forwarder_vpce             = true
  log_forwarder_vpce_subnet_ids         = module.vpc.private_subnets
  log_forwarder_vpce_security_group_ids = [module.security_group.security_group_id]
  log_forwarder_vpce_tags               = { LogForwarderVpcEndpoint = true }

  create_api_vpce             = true
  api_vpce_subnet_ids         = module.vpc.private_subnets
  api_vpce_security_group_ids = [module.security_group.security_group_id]
  api_vpce_tags               = { ApiVpcEndpoint = true }

  create_processes_vpce             = true
  processes_vpce_subnet_ids         = module.vpc.private_subnets
  processes_vpce_security_group_ids = [module.security_group.security_group_id]
  processes_vpce_tags               = { ProcessesVpcEndpoint = true }

  create_traces_vpce             = true
  traces_vpce_subnet_ids         = module.vpc.private_subnets
  traces_vpce_security_group_ids = [module.security_group.security_group_id]
  traces_vpce_tags               = { TracesVpcEndpoint = true }

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

data "aws_iam_policy_document" "custom" {
  statement {
    sid = "AnyResourceAccess"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "tag:GetResources",
      "logs:PutLogEvents",
      "ec2:CreateNetworkInterface",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface"
    ]
    resources = ["*"]
  }

  statement {
    sid = "DatadogBucketFullAccess"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:ListBucket",
    ]
    resources = [
      module.log_bucket_1.s3_bucket_arn,
      "${module.log_bucket_1.s3_bucket_arn}/*"
    ]
  }

  statement {
    sid = "GetApiKeySecret"
    actions = [
      "secretsmanager:GetSecretValue",
    ]
    resources = [
      data.aws_secretsmanager_secret.datadog_api_key.arn
    ]
  }
}

resource "aws_iam_policy" "custom" {
  name        = "custom-datadog-log-forwarder"
  path        = "/"
  description = "Lambda function to push logs, metrics, and traces to Datadog"
  policy      = data.aws_iam_policy_document.custom.json

  tags = local.tags
}

resource "random_pet" "this" {
  length = 2
}

resource "aws_kms_key" "datadog" {
  description         = "Datadog KMS CMK"
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.datadog_cmk.json

  tags = local.tags
}

data "aws_iam_policy_document" "datadog_cmk" {
  statement {
    sid = "CMKOwnerPolicy"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    actions   = ["kms:*"]
    resources = ["*"]
  }
}

resource "aws_kms_alias" "datadog" {
  name          = "alias/datadog/${random_pet.this.id}"
  target_key_id = aws_kms_key.datadog.key_id
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 48)]

  enable_nat_gateway = false

  tags = local.tags
}

module "vpc_endpoints" {
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "~> 5.0"

  vpc_id             = module.vpc.vpc_id
  security_group_ids = [module.security_group.security_group_id]

  endpoints = {
    s3 = {
      service = "s3"
    },
    secretsmanager = {
      service             = "secretsmanager"
      private_dns_enabled = true
      subnet_ids          = module.vpc.private_subnets
    },
  }

  tags = local.tags
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = local.name
  description = "Example security group"
  vpc_id      = module.vpc.vpc_id

  # ingress
  ingress_with_self = [
    {
      rule        = "https-443-tcp"
      description = "Allow all internal HTTPs"
    },
  ]

  # egress
  computed_egress_with_self = [
    {
      rule        = "https-443-tcp"
      description = "Allow all internal HTTPs"
    },
  ]
  number_of_computed_egress_with_self = 1

  egress_cidr_blocks = ["0.0.0.0/0"]
  egress_rules       = ["all-all"]

  tags = local.tags
}

module "log_bucket_1" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 4.0"

  bucket_prefix = "logs-1-"
  force_destroy = true

  control_object_ownership              = true
  attach_elb_log_delivery_policy        = true
  attach_deny_insecure_transport_policy = true

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = local.tags
}

module "log_bucket_2" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 4.0"

  bucket_prefix = "logs-2-"
  force_destroy = true

  control_object_ownership              = true
  attach_elb_log_delivery_policy        = true
  attach_deny_insecure_transport_policy = true

  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = local.tags
}
