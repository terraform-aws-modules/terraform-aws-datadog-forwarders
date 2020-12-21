provider "aws" {
  # Datadogs PrivateLink VPC endpoints are only in us-east-1 currently
  region = "us-east-1"
}

################################################################################
# Data Sources
################################################################################

locals {
  name = "datadog-forwarders-complete-example"
}

# Note: you will need to create this secret manually prior to running
# This avoids having to pass the key to Terraform in plaintext
data "aws_secretsmanager_secret" "datadog_api_key" {
  name = "datadog/api_key"
}

data "aws_secretsmanager_secret_version" "datadog_api_key" {
  secret_id = data.aws_secretsmanager_secret.datadog_api_key.id
}

data "aws_caller_identity" "current" {}

################################################################################
# Supporting Resources
################################################################################

resource "random_pet" "this" {
  length = 2
}

resource "aws_kms_key" "datadog" {
  description         = "Datadog KMS CMK"
  enable_key_rotation = true
  policy              = data.aws_iam_policy_document.datadog_cmk.json
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
  version = "~> 2.64"

  name = local.name
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1c", "us-east-1d"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  # Required for VPC Endpoints
  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_s3_endpoint = true

  enable_secretsmanager_endpoint              = true
  secretsmanager_endpoint_private_dns_enabled = true
  secretsmanager_endpoint_subnet_ids          = module.vpc.private_subnets
  secretsmanager_endpoint_security_group_ids  = [module.security_group.this_security_group_id]
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.17"

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
}


module "log_bucket_1" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 1.17"

  bucket                         = "logs-1-${random_pet.this.id}"
  acl                            = "log-delivery-write"
  force_destroy                  = true
  attach_elb_log_delivery_policy = true
}

module "log_bucket_2" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 1.17"

  bucket                         = "logs-2-${random_pet.this.id}"
  acl                            = "log-delivery-write"
  force_destroy                  = true
  attach_elb_log_delivery_policy = true
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

  log_forwarder_version                        = "3.20.0"
  log_forwarder_name                           = "complete-datadog-log-forwarder"
  log_forwarder_memory_size                    = 512
  log_forwarder_timeout                        = 60
  log_forwarder_publish                        = true
  log_forwarder_reserved_concurrent_executions = 10
  log_forwarder_kms_key_arn                    = aws_kms_alias.datadog.target_key_arn
  log_forwarder_subnet_ids                     = module.vpc.private_subnets
  log_forwarder_security_group_ids             = [module.security_group.this_security_group_id]
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
  log_forwarder_log_retention_days            = 3
  log_forwarder_bucket_prefix                 = "logforwarder"
  log_forwarder_s3_zip_server_side_encryption = "AES256"
  log_forwarder_s3_zip_metadata               = { "alt-name" = "log-forwarder" }
  log_forwarder_s3_zip_tags                   = { LogForwarderZip = true }
  log_forwarder_use_role_name_prefix          = true
  log_forwarder_role_path                     = "/datadog/"
  log_forwarder_role_max_session_duration     = 3900
  log_forwarder_role_tags                     = { ForwarderRole = true }
  log_forwarder_use_policy_name_prefix        = true
  log_forwarder_policy_path                   = "/datadog/"
  log_forwarder_s3_log_bucket_arns            = [module.log_bucket_1.this_s3_bucket_arn, module.log_bucket_2.this_s3_bucket_arn]
  log_forwarder_tags                          = { LogForwarder = true }

  rds_em_forwarder_version                        = "3.19.0"
  rds_em_forwarder_name                           = "complete-datadog-rds-forwarder"
  rds_em_forwarder_memory_size                    = 512
  rds_em_forwarder_timeout                        = 60
  rds_em_forwarder_publish                        = true
  rds_em_forwarder_reserved_concurrent_executions = 10
  rds_em_forwarder_kms_key_arn                    = aws_kms_alias.datadog.target_key_arn
  rds_em_forwarder_subnet_ids                     = module.vpc.private_subnets
  rds_em_forwarder_security_group_ids             = [module.security_group.this_security_group_id]
  rds_em_forwarder_environment_variables          = {}
  rds_em_forwarder_lambda_tags                    = { RdsForwarderLambda = true }
  rds_em_forwarder_log_retention_days             = 3
  rds_em_forwarder_use_role_name_prefix           = true
  rds_em_forwarder_role_path                      = "/datadog/"
  rds_em_forwarder_role_max_session_duration      = 3900
  rds_em_forwarder_role_tags                      = { ForwarderRole = true }
  rds_em_forwarder_use_policy_name_prefix         = true
  rds_em_forwarder_policy_path                    = "/datadog/"
  rds_em_forwarder_tags                           = { RdsForwarder = true }

  vpc_fl_forwarder_version                        = "3.18.0"
  vpc_fl_forwarder_name                           = "complete-datadog-vpc-forwarder"
  vpc_fl_forwarder_memory_size                    = 512
  vpc_fl_forwarder_timeout                        = 60
  vpc_fl_forwarder_publish                        = true
  vpc_fl_forwarder_reserved_concurrent_executions = 10
  vpc_fl_forwarder_kms_key_arn                    = aws_kms_alias.datadog.target_key_arn
  vpc_fl_forwarder_subnet_ids                     = module.vpc.private_subnets
  vpc_fl_forwarder_security_group_ids             = [module.security_group.this_security_group_id]
  vpc_fl_forwarder_environment_variables          = {}
  vpc_fl_forwarder_lambda_tags                    = { VpcForwarderLambda = true }
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
  metrics_vpce_security_group_ids = [module.security_group.this_security_group_id]
  metrics_vpce_tags               = { MetricsVpcEndpoint = true }

  create_agent_vpce             = true
  agent_vpce_subnet_ids         = module.vpc.private_subnets
  agent_vpce_security_group_ids = [module.security_group.this_security_group_id]
  agent_vpce_tags               = { AgentVpcEndpoint = true }

  create_log_forwarder_vpce             = true
  log_forwarder_vpce_subnet_ids         = module.vpc.private_subnets
  log_forwarder_vpce_security_group_ids = [module.security_group.this_security_group_id]
  log_forwarder_vpce_tags               = { LogForwarderVpcEndpoint = true }

  create_api_vpce             = true
  api_vpce_subnet_ids         = module.vpc.private_subnets
  api_vpce_security_group_ids = [module.security_group.this_security_group_id]
  api_vpce_tags               = { ApiVpcEndpoint = true }

  create_processes_vpce             = true
  processes_vpce_subnet_ids         = module.vpc.private_subnets
  processes_vpce_security_group_ids = [module.security_group.this_security_group_id]
  processes_vpce_tags               = { ProcessesVpcEndpoint = true }

  create_traces_vpce             = true
  traces_vpce_subnet_ids         = module.vpc.private_subnets
  traces_vpce_security_group_ids = [module.security_group.this_security_group_id]
  traces_vpce_tags               = { TracesVpcEndpoint = true }

  tags = { Environment = "test" }
}
