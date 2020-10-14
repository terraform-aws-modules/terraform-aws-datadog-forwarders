# Log Forwarder
output "log_forwarder_s3_bucket_arn" {
  description = "The ARN of the log forwarder bucket. Will be of format arn:aws:s3:::bucketname"
  value       = module.default.log_forwarder_s3_bucket_arn
}

output "log_forwarder_s3_bucket_domain_name" {
  description = "The log forwarder bucket domain name. Will be of format bucketname.s3.amazonaws.com"
  value       = module.default.log_forwarder_s3_bucket_arn
}

output "log_forwarder_s3_bucket_regional_domain_name" {
  description = "The log forwarder bucket region-specific domain name. The bucket domain name including the region name"
  value       = module.default.log_forwarder_s3_bucket_regional_domain_name
}

output "log_forwarder_role_arn" {
  description = "The log forwarder lambda role arn"
  value       = module.default.log_forwarder_role_arn
}

output "log_forwarder_role_name" {
  description = "The log forwarder lambda role name"
  value       = module.default.log_forwarder_role_name
}

output "log_forwarder_role_policy_arn" {
  description = "The ARN of the log forwarder lambda role policy"
  value       = module.default.log_forwarder_role_policy_arn
}

output "log_forwarder_role_policy_name" {
  description = "The name of the log forwarder lambda role policy"
  value       = module.default.log_forwarder_role_policy_name
}

output "log_forwarder_s3_object_id" {
  description = "The `key` of the log forwarder lambda zip archive"
  value       = module.default.log_forwarder_s3_object_id
}

output "log_forwarder_s3_object_version" {
  description = "A unique version ID value for the log forwarder lambda zip object, if bucket versioning is enabled"
  value       = module.default.log_forwarder_s3_object_version
}

output "log_forwarder_lambda_arn" {
  description = "The ARN of the log forwarder lambda function"
  value       = module.default.log_forwarder_lambda_arn
}

output "log_forwarder_lambda_qualified_arn" {
  description = "The ARN of the log forwarder lambda function (if versioning is enabled via publish = true)"
  value       = module.default.log_forwarder_lambda_qualified_arn
}

output "log_forwarder_lambda_source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the log forwarder zip file, provided either via filename or s3_* parameters"
  value       = module.default.log_forwarder_lambda_source_code_hash
}

output "log_forwarder_cloudwatch_log_group_arn" {
  description = "The ARN of the log forwarder lambda function CloudWatch log group"
  value       = module.default.log_forwarder_cloudwatch_log_group_arn
}

# RDS Enhanced Monitoring Forwarder
output "rds_em_forwarder_role_arn" {
  description = "The RDS enhanced monitoring forwarder lambda role arn"
  value       = module.default.rds_em_forwarder_role_arn
}

output "rds_em_forwarder_role_name" {
  description = "The RDS enhanced monitoring forwarder lambda role name"
  value       = module.default.rds_em_forwarder_role_name
}

output "rds_em_forwarder_role_policy_arn" {
  description = "The ARN of the RDS enhanced monitoring forwarder lambda role policy"
  value       = module.default.rds_em_forwarder_role_policy_arn
}

output "rds_em_forwarder_role_policy_name" {
  description = "The name of the RDS enhanced monitoring forwarder lambda role policy"
  value       = module.default.rds_em_forwarder_role_policy_name
}

output "rds_em_forwarder_lambda_arn" {
  description = "The ARN of the RDS enhanced monitoring forwarder lambda function"
  value       = module.default.rds_em_forwarder_lambda_arn
}

output "rds_em_forwarder_lambda_qualified_arn" {
  description = "The ARN of the RDS enhanced monitoring forwarder lambda function (if versioning is enabled via publish = true)"
  value       = module.default.rds_em_forwarder_lambda_qualified_arn
}

output "rds_em_forwarder_lambda_source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the RDS enhanced monitoring lambda forwarder zip file, provided either via filename or s3_* parameters"
  value       = module.default.rds_em_forwarder_lambda_source_code_hash
}

output "rds_em_forwarder_cloudwatch_log_group_arn" {
  description = "The ARN of the RDS enhanced monitoring forwarder lambda function CloudWatch log group"
  value       = module.default.rds_em_forwarder_cloudwatch_log_group_arn
}

# VPC Flow Log Forwarder
output "vpc_fl_forwarder_role_arn" {
  description = "The VPC flow log forwarder lambda role arn"
  value       = module.default.vpc_fl_forwarder_role_arn
}

output "vpc_fl_forwarder_role_name" {
  description = "The VPC flow log forwarder lambda role name"
  value       = module.default.vpc_fl_forwarder_role_name
}

output "vpc_fl_forwarder_role_policy_arn" {
  description = "The ARN of the VPC flow log forwarder lambda role policy"
  value       = module.default.vpc_fl_forwarder_role_policy_arn
}

output "vpc_fl_forwarder_role_policy_name" {
  description = "The name of the VPC flow log forwarder lambda role policy"
  value       = module.default.vpc_fl_forwarder_role_policy_name
}

output "vpc_fl_forwarder_lambda_arn" {
  description = "The ARN of the VPC flow log forwarder lambda function"
  value       = module.default.vpc_fl_forwarder_lambda_arn
}

output "vpc_fl_forwarder_lambda_qualified_arn" {
  description = "The ARN of the VPC flow log forwarder lambda function (if versioning is enabled via publish = true)"
  value       = module.default.vpc_fl_forwarder_lambda_qualified_arn
}

output "vpc_fl_forwarder_lambda_source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the VPC flow log forwarder lambda zip file, provided either via filename or s3_* parameters"
  value       = module.default.vpc_fl_forwarder_lambda_source_code_hash
}

output "vpc_fl_forwarder_cloudwatch_log_group_arn" {
  description = "The ARN of the VPC flow log forwarder lambda function CloudWatch log group"
  value       = module.default.vpc_fl_forwarder_cloudwatch_log_group_arn
}


# Metrics VPC Endpoint
output "metrics_endpoint_id" {
  description = "ID of the metrics VPC endpoint"
  value       = module.default.metrics_endpoint_id
}

output "metrics_endpoint_arn" {
  description = "ARN of the metrics VPC endpoint"
  value       = module.default.metrics_endpoint_arn
}

output "metrics_endpoint_dns_entry" {
  description = "DNS entries of the metrics VPC endpoint"
  value       = module.default.metrics_endpoint_dns_entry
}

output "metrics_endpoint_network_interface_ids" {
  description = "One or more network interfaces for the metrics VPC endpoint"
  value       = module.default.metrics_endpoint_network_interface_ids
}

output "metrics_endpoint_owner_id" {
  description = "The ID of the AWS account that owns the metrics VPC endpoint"
  value       = module.default.metrics_endpoint_owner_id
}

output "metrics_endpoint_state" {
  description = "The state of the metrics VPC endpoint"
  value       = module.default.metrics_endpoint_state
}

# Agent VPC Endpoint
output "agent_endpoint_id" {
  description = "ID of the agent VPC endpoint"
  value       = module.default.agent_endpoint_id
}

output "agent_endpoint_arn" {
  description = "ARN of the agent VPC endpoint"
  value       = module.default.agent_endpoint_arn
}

output "agent_endpoint_dns_entry" {
  description = "DNS entries of the agent VPC endpoint"
  value       = module.default.agent_endpoint_dns_entry
}

output "agent_endpoint_network_interface_ids" {
  description = "One or more network interfaces for the agent VPC endpoint"
  value       = module.default.agent_endpoint_network_interface_ids
}

output "agent_endpoint_owner_id" {
  description = "The ID of the AWS account that owns the agent VPC endpoint"
  value       = module.default.agent_endpoint_owner_id
}

output "agent_endpoint_state" {
  description = "The state of the agent VPC endpoint"
  value       = module.default.agent_endpoint_state
}

# Log Forwarder VPC Endpoint
output "log_forwarder_endpoint_id" {
  description = "ID of the log forwarder VPC endpoint"
  value       = module.default.log_forwarder_endpoint_id
}

output "log_forwarder_endpoint_arn" {
  description = "ARN of the log forwarder VPC endpoint"
  value       = module.default.log_forwarder_endpoint_arn
}

output "log_forwarder_endpoint_dns_entry" {
  description = "DNS entries of the log forwarder VPC endpoint"
  value       = module.default.log_forwarder_endpoint_dns_entry
}

output "log_forwarder_endpoint_network_interface_ids" {
  description = "One or more network interfaces for the log forwarder VPC endpoint"
  value       = module.default.log_forwarder_endpoint_network_interface_ids
}

output "log_forwarder_endpoint_owner_id" {
  description = "The ID of the AWS account that owns the log forwarder VPC endpoint"
  value       = module.default.log_forwarder_endpoint_owner_id
}

output "log_forwarder_endpoint_state" {
  description = "The state of the log forwarder VPC endpoint"
  value       = module.default.log_forwarder_endpoint_state
}

# API VPC Endpoint
output "api_endpoint_id" {
  description = "ID of the API VPC endpoint"
  value       = module.default.api_endpoint_id
}

output "api_endpoint_arn" {
  description = "ARN of the API VPC endpoint"
  value       = module.default.api_endpoint_arn
}

output "api_endpoint_dns_entry" {
  description = "DNS entries of the API VPC endpoint"
  value       = module.default.api_endpoint_dns_entry
}

output "api_endpoint_network_interface_ids" {
  description = "One or more network interfaces for API api VPC endpoint"
  value       = module.default.api_endpoint_network_interface_ids
}

output "api_endpoint_owner_id" {
  description = "The ID of the AWS account that owns the API VPC endpoint"
  value       = module.default.api_endpoint_owner_id
}

output "api_endpoint_state" {
  description = "The state of the API VPC endpoint"
  value       = module.default.api_endpoint_state
}

# Processes VPC Endpoint
output "processes_endpoint_id" {
  description = "ID of the processes VPC endpoint"
  value       = module.default.processes_endpoint_id
}

output "processes_endpoint_arn" {
  description = "ARN of the processes VPC endpoint"
  value       = module.default.processes_endpoint_arn
}

output "processes_endpoint_dns_entry" {
  description = "DNS entries of the processes VPC endpoint"
  value       = module.default.processes_endpoint_dns_entry
}

output "processes_endpoint_network_interface_ids" {
  description = "One or more network interfaces for the processes VPC endpoint"
  value       = module.default.processes_endpoint_network_interface_ids
}

output "processes_endpoint_owner_id" {
  description = "The ID of the AWS account that owns the processes VPC endpoint"
  value       = module.default.processes_endpoint_owner_id
}

output "processes_endpoint_state" {
  description = "The state of the processes VPC endpoint"
  value       = module.default.processes_endpoint_state
}

# Traces VPC Endpoint
output "traces_endpoint_id" {
  description = "ID of the traces VPC endpoint"
  value       = module.default.traces_endpoint_id
}

output "traces_endpoint_arn" {
  description = "ARN of the traces VPC endpoint"
  value       = module.default.traces_endpoint_arn
}

output "traces_endpoint_dns_entry" {
  description = "DNS entries of the traces VPC endpoint"
  value       = module.default.traces_endpoint_dns_entry
}

output "traces_endpoint_network_interface_ids" {
  description = "One or more network interfaces for the traces VPC endpoint"
  value       = module.default.traces_endpoint_network_interface_ids
}

output "traces_endpoint_owner_id" {
  description = "The ID of the AWS account that owns the traces VPC endpoint"
  value       = module.default.traces_endpoint_owner_id
}

output "traces_endpoint_state" {
  description = "The state of the traces VPC endpoint"
  value       = module.default.traces_endpoint_state
}
