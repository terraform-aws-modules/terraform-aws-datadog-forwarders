# Log Forwarder
output "log_forwarder_s3_bucket_id" {
  description = "The name of the log forwarder bucket"
  value       = module.log_forwarder.s3_bucket_id
}

output "log_forwarder_s3_bucket_arn" {
  description = "The ARN of the log forwarder bucket. Will be of format arn:aws:s3:::bucketname"
  value       = module.log_forwarder.s3_bucket_arn
}

output "log_forwarder_s3_bucket_domain_name" {
  description = "The log forwarder bucket domain name. Will be of format bucketname.s3.amazonaws.com"
  value       = module.log_forwarder.s3_bucket_domain_name
}

output "log_forwarder_s3_bucket_regional_domain_name" {
  description = "The log forwarder bucket region-specific domain name. The bucket domain name including the region name"
  value       = module.log_forwarder.s3_bucket_regional_domain_name
}

output "log_forwarder_role_arn" {
  description = "The log forwarder lambda role arn"
  value       = module.log_forwarder.role_arn
}

output "log_forwarder_role_id" {
  description = "The log forwarder lambda role id"
  value       = module.log_forwarder.role_id
}

output "log_forwarder_role_name" {
  description = "The log forwarder lambda role name"
  value       = module.log_forwarder.role_name
}

output "log_forwarder_role_unique_id" {
  description = "The stable and unique string identifying the log forwarder lambda role"
  value       = module.log_forwarder.role_unique_id
}

output "log_forwarder_role_policy_arn" {
  description = "The ARN of the log forwarder lambda role policy"
  value       = module.log_forwarder.role_policy_arn
}

output "log_forwarder_role_policy_id" {
  description = "The ID of the log forwarder lambda role policy"
  value       = module.log_forwarder.role_policy_id
}

output "log_forwarder_role_policy_name" {
  description = "The name of the log forwarder lambda role policy"
  value       = module.log_forwarder.role_policy_name
}

output "log_forwarder_s3_object_id" {
  description = "The `key` of the log forwarder lambda zip archive"
  value       = module.log_forwarder.s3_object_id
}

output "log_forwarder_s3_object_etag" {
  description = "The ETag generated for the log forwarder lambda zip object (an MD5 sum of the object content)"
  value       = module.log_forwarder.s3_object_etag
}

output "log_forwarder_s3_object_version" {
  description = "A unique version ID value for the log forwarder lambda zip object, if bucket versioning is enabled"
  value       = module.log_forwarder.s3_object_version
}

output "log_forwarder_lambda_arn" {
  description = "The ARN of the log forwarder lambda function"
  value       = module.log_forwarder.lambda_arn
}

output "log_forwarder_lambda_qualified_arn" {
  description = "The ARN of the log forwarder lambda function (if versioning is enabled via publish = true)"
  value       = module.log_forwarder.lambda_qualified_arn
}

output "log_forwarder_lambda_version" {
  description = "Latest published version of the log forwarder lambda function"
  value       = module.log_forwarder.lambda_version
}

output "log_forwarder_lambda_kms_key_arn" {
  description = "(Optional) The ARN for the KMS encryption key for the log forwarder lambda function"
  value       = module.log_forwarder.lambda_kms_key_arn
}

output "log_forwarder_lambda_source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the log forwarder zip file, provided either via filename or s3_* parameters"
  value       = module.log_forwarder.lambda_source_code_hash
}

output "log_forwarder_cloudwatch_log_group_arn" {
  description = "The ARN of the log forwarder lambda function CloudWatch log group"
  value       = module.log_forwarder.cloudwatch_log_group_arn
}

# RDS Enhanced Monitoring Forwarder
output "rds_em_forwarder_role_arn" {
  description = "The RDS enhanced monitoring forwarder lambda role arn"
  value       = module.rds_enhanced_monitoring_forwarder.role_arn
}

output "rds_em_forwarder_role_id" {
  description = "The RDS enhanced monitoring forwarder lambda role id"
  value       = module.rds_enhanced_monitoring_forwarder.role_id
}

output "rds_em_forwarder_role_name" {
  description = "The RDS enhanced monitoring forwarder lambda role name"
  value       = module.rds_enhanced_monitoring_forwarder.role_name
}

output "rds_em_forwarder_role_unique_id" {
  description = "The stable and unique string identifying the RDS enhanced monitoring forwarder lambda role."
  value       = module.rds_enhanced_monitoring_forwarder.role_unique_id
}

output "rds_em_forwarder_role_policy_arn" {
  description = "The ARN of the RDS enhanced monitoring forwarder lambda role policy"
  value       = module.rds_enhanced_monitoring_forwarder.role_policy_arn
}

output "rds_em_forwarder_role_policy_id" {
  description = "The ID of the RDS enhanced monitoring forwarder lambda role policy"
  value       = module.rds_enhanced_monitoring_forwarder.role_policy_id
}

output "rds_em_forwarder_role_policy_name" {
  description = "The name of the RDS enhanced monitoring forwarder lambda role policy"
  value       = module.rds_enhanced_monitoring_forwarder.role_policy_name
}

output "rds_em_forwarder_lambda_arn" {
  description = "The ARN of the RDS enhanced monitoring forwarder lambda function"
  value       = module.rds_enhanced_monitoring_forwarder.lambda_arn
}

output "rds_em_forwarder_lambda_qualified_arn" {
  description = "The ARN of the RDS enhanced monitoring forwarder lambda function (if versioning is enabled via publish = true)"
  value       = module.rds_enhanced_monitoring_forwarder.lambda_qualified_arn
}

output "rds_em_forwarder_lambda_version" {
  description = "Latest published version of the RDS enhanced monitoring forwarder lambda function"
  value       = module.rds_enhanced_monitoring_forwarder.lambda_version
}

output "rds_em_forwarder_lambda_kms_key_arn" {
  description = "(Optional) The ARN for the KMS encryption key for the RDS enhanced monitoring forwarder lambda function"
  value       = module.rds_enhanced_monitoring_forwarder.lambda_kms_key_arn
}

output "rds_em_forwarder_lambda_source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the RDS enhanced monitoring lambda forwarder zip file, provided either via filename or s3_* parameters"
  value       = module.rds_enhanced_monitoring_forwarder.lambda_source_code_hash
}

output "rds_em_forwarder_cloudwatch_log_group_arn" {
  description = "The ARN of the RDS enhanced monitoring forwarder lambda function CloudWatch log group"
  value       = module.rds_enhanced_monitoring_forwarder.cloudwatch_log_group_arn
}

# VPC Flow Log Forwarder
output "vpc_fl_forwarder_role_arn" {
  description = "The VPC flow log forwarder lambda role arn"
  value       = module.vpc_flow_log_forwarder.role_arn
}

output "vpc_fl_forwarder_role_id" {
  description = "The VPC flow log forwarder lambda role id"
  value       = module.vpc_flow_log_forwarder.role_id
}

output "vpc_fl_forwarder_role_name" {
  description = "The VPC flow log forwarder lambda role name"
  value       = module.vpc_flow_log_forwarder.role_name
}

output "vpc_fl_forwarder_role_unique_id" {
  description = "The stable and unique string identifying the VPC flow log forwarder lambda role."
  value       = module.vpc_flow_log_forwarder.role_unique_id
}

output "vpc_fl_forwarder_role_policy_arn" {
  description = "The ARN of the VPC flow log forwarder lambda role policy"
  value       = module.vpc_flow_log_forwarder.role_policy_arn
}

output "vpc_fl_forwarder_role_policy_id" {
  description = "The ID of the VPC flow log forwarder lambda role policy"
  value       = module.vpc_flow_log_forwarder.role_policy_id
}

output "vpc_fl_forwarder_role_policy_name" {
  description = "The name of the VPC flow log forwarder lambda role policy"
  value       = module.vpc_flow_log_forwarder.role_policy_name
}

output "vpc_fl_forwarder_lambda_arn" {
  description = "The ARN of the VPC flow log forwarder lambda function"
  value       = module.vpc_flow_log_forwarder.lambda_arn
}

output "vpc_fl_forwarder_lambda_qualified_arn" {
  description = "The ARN of the VPC flow log forwarder lambda function (if versioning is enabled via publish = true)"
  value       = module.vpc_flow_log_forwarder.lambda_qualified_arn
}

output "vpc_fl_forwarder_lambda_version" {
  description = "Latest published version of the VPC flow log forwarder lambda function"
  value       = module.vpc_flow_log_forwarder.lambda_version
}

output "vpc_fl_forwarder_lambda_kms_key_arn" {
  description = "(Optional) The ARN for the KMS encryption key for the VPC flow log forwarder lambda function"
  value       = module.vpc_flow_log_forwarder.lambda_kms_key_arn
}

output "vpc_fl_forwarder_lambda_source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the VPC flow log forwarder lambda zip file, provided either via filename or s3_* parameters"
  value       = module.vpc_flow_log_forwarder.lambda_source_code_hash
}

output "vpc_fl_forwarder_cloudwatch_log_group_arn" {
  description = "The ARN of the VPC flow log forwarder lambda function CloudWatch log group"
  value       = module.vpc_flow_log_forwarder.cloudwatch_log_group_arn
}

# Metrics VPC Endpoint
output "metrics_endpoint_id" {
  description = "ID of the metrics VPC endpoint"
  value       = try(aws_vpc_endpoint.metrics[0].id, "")
}

output "metrics_endpoint_arn" {
  description = "ARN of the metrics VPC endpoint"
  value       = try(aws_vpc_endpoint.metrics[0].arn, "")
}

output "metrics_endpoint_dns_entry" {
  description = "DNS entries of the metrics VPC endpoint"
  value       = try(aws_vpc_endpoint.metrics[0].dns_entry, "")
}

output "metrics_endpoint_network_interface_ids" {
  description = "One or more network interfaces for the metrics VPC endpoint"
  value       = try(aws_vpc_endpoint.metrics[0].network_interface_ids, "")
}

output "metrics_endpoint_owner_id" {
  description = "The ID of the AWS account that owns the metrics VPC endpoint"
  value       = try(aws_vpc_endpoint.metrics[0].owner_id, "")
}

output "metrics_endpoint_state" {
  description = "The state of the metrics VPC endpoint"
  value       = try(aws_vpc_endpoint.metrics[0].state, "")
}

# Agent VPC Endpoint
output "agent_endpoint_id" {
  description = "ID of the agent VPC endpoint"
  value       = try(aws_vpc_endpoint.agent[0].id, "")
}

output "agent_endpoint_arn" {
  description = "ARN of the agent VPC endpoint"
  value       = try(aws_vpc_endpoint.agent[0].arn, "")
}

output "agent_endpoint_dns_entry" {
  description = "DNS entries of the agent VPC endpoint"
  value       = try(aws_vpc_endpoint.agent[0].dns_entry, "")
}

output "agent_endpoint_network_interface_ids" {
  description = "One or more network interfaces for the agent VPC endpoint"
  value       = try(aws_vpc_endpoint.agent[0].network_interface_ids, "")
}

output "agent_endpoint_owner_id" {
  description = "The ID of the AWS account that owns the agent VPC endpoint"
  value       = try(aws_vpc_endpoint.agent[0].owner_id, "")
}

output "agent_endpoint_state" {
  description = "The state of the agent VPC endpoint"
  value       = try(aws_vpc_endpoint.agent[0].state, "")
}

# Log Forwarder VPC Endpoint
output "log_forwarder_endpoint_id" {
  description = "ID of the log forwarder VPC endpoint"
  value       = try(aws_vpc_endpoint.log_forwarder[0].id, "")
}

output "log_forwarder_endpoint_arn" {
  description = "ARN of the log forwarder VPC endpoint"
  value       = try(aws_vpc_endpoint.log_forwarder[0].arn, "")
}

output "log_forwarder_endpoint_dns_entry" {
  description = "DNS entries of the log forwarder VPC endpoint"
  value       = try(aws_vpc_endpoint.log_forwarder[0].dns_entry, "")
}

output "log_forwarder_endpoint_network_interface_ids" {
  description = "One or more network interfaces for the log forwarder VPC endpoint"
  value       = try(aws_vpc_endpoint.log_forwarder[0].network_interface_ids, "")
}

output "log_forwarder_endpoint_owner_id" {
  description = "The ID of the AWS account that owns the log forwarder VPC endpoint"
  value       = try(aws_vpc_endpoint.log_forwarder[0].owner_id, "")
}

output "log_forwarder_endpoint_state" {
  description = "The state of the log forwarder VPC endpoint"
  value       = try(aws_vpc_endpoint.log_forwarder[0].state, "")
}

# API VPC Endpoint
output "api_endpoint_id" {
  description = "ID of the API VPC endpoint"
  value       = try(aws_vpc_endpoint.api[0].id, "")
}

output "api_endpoint_arn" {
  description = "ARN of the API VPC endpoint"
  value       = try(aws_vpc_endpoint.api[0].arn, "")
}

output "api_endpoint_dns_entry" {
  description = "DNS entries of the API VPC endpoint"
  value       = try(aws_vpc_endpoint.api[0].dns_entry, "")
}

output "api_endpoint_network_interface_ids" {
  description = "One or more network interfaces for API api VPC endpoint"
  value       = try(aws_vpc_endpoint.api[0].network_interface_ids, "")
}

output "api_endpoint_owner_id" {
  description = "The ID of the AWS account that owns the API VPC endpoint"
  value       = try(aws_vpc_endpoint.api[0].owner_id, "")
}

output "api_endpoint_state" {
  description = "The state of the API VPC endpoint"
  value       = try(aws_vpc_endpoint.api[0].state, "")
}

# Processes VPC Endpoint
output "processes_endpoint_id" {
  description = "ID of the processes VPC endpoint"
  value       = try(aws_vpc_endpoint.processes[0].id, "")
}

output "processes_endpoint_arn" {
  description = "ARN of the processes VPC endpoint"
  value       = try(aws_vpc_endpoint.processes[0].arn, "")
}

output "processes_endpoint_dns_entry" {
  description = "DNS entries of the processes VPC endpoint"
  value       = try(aws_vpc_endpoint.processes[0].dns_entry, "")
}

output "processes_endpoint_network_interface_ids" {
  description = "One or more network interfaces for the processes VPC endpoint"
  value       = try(aws_vpc_endpoint.processes[0].network_interface_ids, "")
}

output "processes_endpoint_owner_id" {
  description = "The ID of the AWS account that owns the processes VPC endpoint"
  value       = try(aws_vpc_endpoint.processes[0].owner_id, "")
}

output "processes_endpoint_state" {
  description = "The state of the processes VPC endpoint"
  value       = try(aws_vpc_endpoint.processes[0].state, "")
}

# Traces VPC Endpoint
output "traces_endpoint_id" {
  description = "ID of the traces VPC endpoint"
  value       = try(aws_vpc_endpoint.traces[0].id, "")
}

output "traces_endpoint_arn" {
  description = "ARN of the traces VPC endpoint"
  value       = try(aws_vpc_endpoint.traces[0].arn, "")
}

output "traces_endpoint_dns_entry" {
  description = "DNS entries of the traces VPC endpoint"
  value       = try(aws_vpc_endpoint.traces[0].dns_entry, "")
}

output "traces_endpoint_network_interface_ids" {
  description = "One or more network interfaces for the traces VPC endpoint"
  value       = try(aws_vpc_endpoint.traces[0].network_interface_ids, "")
}

output "traces_endpoint_owner_id" {
  description = "The ID of the AWS account that owns the traces VPC endpoint"
  value       = try(aws_vpc_endpoint.traces[0].owner_id, "")
}

output "traces_endpoint_state" {
  description = "The state of the traces VPC endpoint"
  value       = try(aws_vpc_endpoint.traces[0].state, "")
}
