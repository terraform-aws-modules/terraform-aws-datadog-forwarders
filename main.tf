################################################################################
# Log Forwarder
################################################################################

module "log_forwarder" {
  source = "./modules/log_forwarder"

  create = var.create_log_forwarder

  forwarder_version     = var.log_forwarder_version
  dd_api_key            = var.dd_api_key
  dd_api_key_secret_arn = var.dd_api_key_secret_arn
  dd_site               = var.dd_site

  name                           = var.log_forwarder_name
  runtime                        = var.log_forwarder_runtime
  layers                         = var.log_forwarder_layers
  memory_size                    = var.log_forwarder_memory_size
  timeout                        = var.log_forwarder_timeout
  publish                        = var.log_forwarder_publish
  architectures                  = var.log_forwarder_architectures
  reserved_concurrent_executions = var.log_forwarder_reserved_concurrent_executions
  kms_key_arn                    = var.log_forwarder_kms_key_arn
  subnet_ids                     = var.log_forwarder_subnet_ids
  security_group_ids             = var.log_forwarder_security_group_ids
  environment_variables          = var.log_forwarder_environment_variables
  lambda_tags                    = var.log_forwarder_lambda_tags
  log_retention_days             = var.log_forwarder_log_retention_days
  log_kms_key_id                 = var.log_forwarder_log_kms_key_id

  create_bucket                                = var.create_bucket
  bucket_name                                  = var.bucket_name
  bucket_prefix                                = var.log_forwarder_bucket_prefix
  bucket_attach_deny_insecure_transport_policy = var.bucket_attach_deny_insecure_transport_policy
  bucket_encryption_settings                   = var.bucket_encryption_settings

  s3_zip_storage_class          = var.log_forwarder_s3_zip_storage_class
  s3_zip_server_side_encryption = var.log_forwarder_s3_zip_server_side_encryption
  s3_zip_kms_key_id             = var.log_forwarder_s3_zip_kms_key_id
  s3_zip_metadata               = var.log_forwarder_s3_zip_metadata
  s3_zip_tags                   = var.log_forwarder_s3_zip_tags
  s3_zip_tags_only              = var.log_forwarder_s3_zip_tags_only

  create_role               = var.create_log_forwarder_role
  role_arn                  = var.log_forwarder_role_arn
  role_name                 = var.log_forwarder_role_name
  use_role_name_prefix      = var.log_forwarder_use_role_name_prefix
  role_path                 = var.log_forwarder_role_path
  role_max_session_duration = var.log_forwarder_role_max_session_duration
  role_permissions_boundary = var.log_forwarder_role_permissions_boundary
  role_tags                 = var.log_forwarder_role_tags
  create_role_policy        = var.create_log_forwarder_role_policy
  policy_arn                = var.log_forwarder_policy_arn
  policy_name               = var.log_forwarder_policy_name
  use_policy_name_prefix    = var.log_forwarder_use_policy_name_prefix
  policy_path               = var.log_forwarder_policy_path
  s3_log_bucket_arns        = var.log_forwarder_s3_log_bucket_arns

  tags = merge(var.tags, var.log_forwarder_tags)
}

################################################################################
# RDS Enhanced Monitoring Forwarder
################################################################################

module "rds_enhanced_monitoring_forwarder" {
  source = "./modules/rds_enhanced_monitoring_forwarder"

  create = var.create_rds_em_forwarder

  forwarder_version     = var.rds_em_forwarder_version
  dd_api_key            = var.dd_api_key
  dd_api_key_secret_arn = var.dd_api_key_secret_arn
  dd_site               = var.dd_site

  name                           = var.rds_em_forwarder_name
  runtime                        = var.rds_em_forwarder_runtime
  layers                         = var.rds_em_forwarder_layers
  memory_size                    = var.rds_em_forwarder_memory_size
  timeout                        = var.rds_em_forwarder_timeout
  publish                        = var.rds_em_forwarder_publish
  architectures                  = var.rds_em_forwarder_architectures
  reserved_concurrent_executions = var.rds_em_forwarder_reserved_concurrent_executions
  kms_key_arn                    = var.rds_em_forwarder_kms_key_arn
  subnet_ids                     = var.rds_em_forwarder_subnet_ids
  security_group_ids             = var.rds_em_forwarder_security_group_ids
  environment_variables          = var.rds_em_forwarder_environment_variables
  lambda_tags                    = var.rds_em_forwarder_lambda_tags
  log_retention_days             = var.rds_em_forwarder_log_retention_days
  log_kms_key_id                 = var.rds_em_forwarder_log_kms_key_id

  create_role               = var.create_rds_em_forwarder_role
  role_arn                  = var.rds_em_forwarder_role_arn
  role_name                 = var.rds_em_forwarder_role_name
  use_role_name_prefix      = var.rds_em_forwarder_use_role_name_prefix
  role_path                 = var.rds_em_forwarder_role_path
  role_max_session_duration = var.rds_em_forwarder_role_max_session_duration
  role_permissions_boundary = var.rds_em_forwarder_role_permissions_boundary
  role_tags                 = var.rds_em_forwarder_role_tags
  create_role_policy        = var.create_rds_em_forwarder_role_policy
  policy_arn                = var.rds_em_forwarder_policy_arn
  policy_name               = var.rds_em_forwarder_policy_name
  use_policy_name_prefix    = var.rds_em_forwarder_use_policy_name_prefix
  policy_path               = var.rds_em_forwarder_policy_path

  tags = merge(var.tags, var.rds_em_forwarder_tags)
}

################################################################################
# VPC Flow Log Forwarder
################################################################################

module "vpc_flow_log_forwarder" {
  source = "./modules/vpc_flow_log_forwarder"

  create = var.create_vpc_fl_forwarder

  forwarder_version     = var.vpc_fl_forwarder_version
  dd_api_key_secret_arn = var.dd_api_key_secret_arn
  dd_app_key            = var.dd_app_key
  dd_site               = var.dd_site
  kms_alias             = var.kms_alias

  name                           = var.vpc_fl_forwarder_name
  runtime                        = var.vpc_fl_forwarder_runtime
  layers                         = var.vpc_fl_forwarder_layers
  memory_size                    = var.vpc_fl_forwarder_memory_size
  timeout                        = var.vpc_fl_forwarder_timeout
  publish                        = var.vpc_fl_forwarder_publish
  architectures                  = var.vpc_fl_forwarder_architectures
  reserved_concurrent_executions = var.vpc_fl_forwarder_reserved_concurrent_executions
  kms_key_arn                    = var.vpc_fl_forwarder_kms_key_arn
  subnet_ids                     = var.vpc_fl_forwarder_subnet_ids
  security_group_ids             = var.vpc_fl_forwarder_security_group_ids
  environment_variables          = var.vpc_fl_forwarder_environment_variables
  lambda_tags                    = var.vpc_fl_forwarder_lambda_tags
  log_retention_days             = var.vpc_fl_forwarder_log_retention_days
  log_kms_key_id                 = var.vpc_fl_forwarder_log_kms_key_id

  create_role               = var.create_vpc_fl_forwarder_role
  role_arn                  = var.vpc_fl_forwarder_role_arn
  role_name                 = var.vpc_fl_forwarder_role_name
  use_role_name_prefix      = var.vpc_fl_forwarder_use_role_name_prefix
  role_path                 = var.vpc_fl_forwarder_role_path
  role_max_session_duration = var.vpc_fl_forwarder_role_max_session_duration
  role_permissions_boundary = var.vpc_fl_forwarder_role_permissions_boundary
  role_tags                 = var.vpc_fl_forwarder_role_tags
  create_role_policy        = var.create_vpc_fl_forwarder_role_policy
  policy_arn                = var.vpc_fl_forwarder_policy_arn
  policy_name               = var.vpc_fl_forwarder_policy_name
  use_policy_name_prefix    = var.vpc_fl_forwarder_use_policy_name_prefix
  policy_path               = var.vpc_fl_forwarder_policy_path
  s3_log_bucket_arns        = var.vpc_fl_forwarder_s3_log_bucket_arns
  read_cloudwatch_logs      = var.vpc_fl_forwarder_read_cloudwatch_logs

  tags = merge(var.tags, var.vpc_fl_forwarder_tags)
}

################################################################################
# PrivateLink / VPC Endpoints
################################################################################

resource "aws_vpc_endpoint" "metrics" {
  count = var.create_metrics_vpce ? 1 : 0

  service_name        = "com.amazonaws.vpce.us-east-1.vpce-svc-056576c12b36056ca"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  vpc_id             = var.vpc_id
  subnet_ids         = var.metrics_vpce_subnet_ids
  security_group_ids = var.metrics_vpce_security_group_ids
  policy             = var.metrics_vpce_policy

  tags = merge({ Name = "datadog-metrics" }, var.tags, var.metrics_vpce_tags)
}

resource "aws_vpc_endpoint" "agent" {
  count = var.create_agent_vpce ? 1 : 0

  service_name        = "com.amazonaws.vpce.us-east-1.vpce-svc-0a2aef8496ee043bf"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  vpc_id             = var.vpc_id
  subnet_ids         = var.agent_vpce_subnet_ids
  security_group_ids = var.agent_vpce_security_group_ids
  policy             = var.agent_vpce_policy

  tags = merge({ Name = "datadog-agent" }, var.tags, var.agent_vpce_tags)
}

resource "aws_vpc_endpoint" "log_forwarder" {
  count = var.create_log_forwarder_vpce ? 1 : 0

  service_name        = "com.amazonaws.vpce.us-east-1.vpce-svc-06394d10ccaf6fb97"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  vpc_id             = var.vpc_id
  subnet_ids         = var.log_forwarder_vpce_subnet_ids
  security_group_ids = var.log_forwarder_vpce_security_group_ids
  policy             = var.log_forwarder_vpce_policy

  tags = merge({ Name = "datadog-log-forwarder" }, var.tags, var.log_forwarder_vpce_tags)
}

resource "aws_vpc_endpoint" "api" {
  count = var.create_api_vpce ? 1 : 0

  service_name        = "com.amazonaws.vpce.us-east-1.vpce-svc-02a4a57bc703929a0"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  vpc_id             = var.vpc_id
  subnet_ids         = var.api_vpce_subnet_ids
  security_group_ids = var.api_vpce_security_group_ids
  policy             = var.api_vpce_policy

  tags = merge({ Name = "datadog-api" }, var.tags, var.api_vpce_tags)
}

resource "aws_vpc_endpoint" "processes" {
  count = var.create_processes_vpce ? 1 : 0

  service_name        = "com.amazonaws.vpce.us-east-1.vpce-svc-05316fe237f6d8ddd"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  vpc_id             = var.vpc_id
  subnet_ids         = var.processes_vpce_subnet_ids
  security_group_ids = var.processes_vpce_security_group_ids
  policy             = var.processes_vpce_policy

  tags = merge({ Name = "datadog-processes" }, var.tags, var.processes_vpce_tags)
}

resource "aws_vpc_endpoint" "traces" {
  count = var.create_traces_vpce ? 1 : 0

  service_name        = "com.amazonaws.vpce.us-east-1.vpce-svc-07672d13af0033c24"
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true

  vpc_id             = var.vpc_id
  subnet_ids         = var.traces_vpce_subnet_ids
  security_group_ids = var.traces_vpce_security_group_ids
  policy             = var.traces_vpce_policy

  tags = merge({ Name = "datadog-traces" }, var.tags, var.traces_vpce_tags)
}
