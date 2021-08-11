variable "tags" {
  description = "A map of tags to use on all resources"
  type        = map(string)
  default     = {}
}

# Datadog environment Variables
variable "dd_api_key" {
  description = "The Datadog API key, which can be found from the APIs page (/account/settings#api). It will be stored in AWS Secrets Manager securely. If DdApiKeySecretArn is also set, this value will not be used. This value must still be set, however"
  type        = string
  default     = ""
}

variable "dd_api_key_secret_arn" {
  description = "The ARN of the Secrets Manager secret storing the Datadog API key, if you already have it stored in Secrets Manager. You still need to set a dummy value for `dd_api_key` to satisfy the requirement, though that value won't be used"
  type        = string
  default     = ""
}

variable "dd_app_key" {
  description = "The Datadog application key associated with the user account that created it, which can be found from the APIs page"
  type        = string
  default     = ""
}

variable "dd_site" {
  description = "Define your Datadog Site to send data to. For the Datadog EU site, set to datadoghq.eu"
  type        = string
  default     = "datadoghq.com"
}

variable "kms_alias" {
  description = "Alias of KMS key used to encrypt the Datadog API keys - must start with `alias/`"
  type        = string
}

# Log Forwarder S3 Bucket
variable "create_bucket" {
  description = "Controls whether an S3 artifact bucket should be created. this is used for the zip archive as well as caching tags"
  type        = bool
  default     = true
}

variable "bucket_name" {
  description = "Lambda artifact S3 bucket name"
  type        = string
  default     = ""
}

variable "bucket_attach_deny_insecure_transport_policy" {
  description = "Controls if S3 bucket should have deny non-SSL transport policy attacheds"
  type        = bool
  default     = false
}

# Log Forwarder S3 Objcet
variable "log_forwarder_bucket_prefix" {
  description = "S3 object key prefix to prepend to zip archive name"
  type        = string
  default     = ""
}

variable "log_forwarder_s3_zip_storage_class" {
  description = "Specifies the desired Storage Class for the zip object. Can be either `STANDARD`, `REDUCED_REDUNDANCY`, `ONEZONE_IA`, `INTELLIGENT_TIERING`, or `STANDARD_IA`"
  type        = string
  default     = null
}

variable "log_forwarder_s3_zip_server_side_encryption" {
  description = "Server-side encryption of the zip object in S3. Valid values are `AES256` and `aws:kms`"
  type        = string
  default     = null
}

variable "log_forwarder_s3_zip_kms_key_id" {
  description = "The AWS KMS Key ARN to use for object encryption"
  type        = string
  default     = null
}

variable "log_forwarder_s3_zip_metadata" {
  description = "A map of keys/values to provision metadata (will be automatically prefixed by `x-amz-meta-`"
  type        = map(string)
  default     = {}
}

variable "log_forwarder_s3_zip_tags" {
  description = "A map of tags to apply to the zip archive in S3"
  type        = map(string)
  default     = {}
}

# Log Forwarder IAM Role
variable "create_log_forwarder_role" {
  description = "Controls whether an IAM role is created for the log forwarder"
  type        = bool
  default     = true
}

variable "log_forwarder_role_arn" {
  description = "IAM role arn for log forwarder lambda function to utilize"
  type        = string
  default     = null
}

variable "log_forwarder_role_name" {
  description = "Log forwarder role name"
  type        = string
  default     = ""
}

variable "log_forwarder_use_role_name_prefix" {
  description = "Whether to use unique name beginning with the specified `role_name` for the log forwarder role"
  type        = bool
  default     = false
}

variable "log_forwarder_role_path" {
  description = "Log forwarder role path"
  type        = string
  default     = null
}

variable "log_forwarder_role_max_session_duration" {
  description = "The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
  type        = number
  default     = null
}

variable "log_forwarder_role_permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the log forwarder role."
  type        = string
  default     = null
}

variable "log_forwarder_role_tags" {
  description = "A map of tags to apply to the log forwarder role"
  type        = map(string)
  default     = {}
}

variable "create_log_forwarder_role_policy" {
  description = "Controls whether an IAM role policy is created for the log forwarder"
  type        = bool
  default     = true
}

variable "log_forwarder_policy_arn" {
  description = "IAM policy arn for log forwarder lambda function to utilize"
  type        = string
  default     = null
}

variable "log_forwarder_policy_name" {
  description = "Log forwarder policy name"
  type        = string
  default     = ""
}

variable "log_forwarder_use_policy_name_prefix" {
  description = "Whether to use unique name beginning with the specified `policy_name` for the log forwarder policy"
  type        = bool
  default     = false
}

variable "log_forwarder_policy_path" {
  description = "Log forwarder policy path"
  type        = string
  default     = null
}

variable "log_forwarder_s3_log_bucket_arns" {
  description = "S3 log buckets for forwarder to read and forward logs to Datadog"
  type        = list(string)
  default     = []
}

# log Forwarder Lambda Function
variable "log_forwarder_version" {
  description = "Forwarder version - see https://github.com/DataDog/datadog-serverless-functions/releases"
  type        = string
  default     = "3.37.0"
}

variable "create_log_forwarder" {
  description = "Controls whether log forwarder resources should be created"
  type        = bool
  default     = true
}

variable "log_forwarder_name" {
  description = "Log forwarder lambda name"
  type        = string
  default     = "datadog-log-forwarder"
}

variable "log_forwarder_runtime" {
  description = "Lambda function runtime"
  type        = string
  default     = "python3.7"
}

variable "log_forwarder_layers" {
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to the log forwarder lambda"
  type        = list(string)
  default     = []
}

variable "log_forwarder_memory_size" {
  description = "Memory size for the log forwarder lambda function"
  type        = number
  default     = 1024
}

variable "log_forwarder_timeout" {
  description = "The amount of time the log forwarder lambda has to execute in seconds"
  type        = number
  default     = 120
}

variable "log_forwarder_publish" {
  description = "Whether to publish creation/change as a new Lambda Function Version"
  type        = bool
  default     = false
}

variable "log_forwarder_reserved_concurrent_executions" {
  description = "The amount of reserved concurrent executions for the log forwarder lambda function"
  type        = number
  default     = 100
}

variable "log_forwarder_kms_key_arn" {
  description = "KMS key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key"
  type        = string
  default     = null
}

variable "log_forwarder_subnet_ids" {
  description = "List of subnet ids when forwarder lambda function should run in the VPC. Usually private or intra subnets."
  type        = list(string)
  default     = null
}

variable "log_forwarder_security_group_ids" {
  description = "List of security group ids when forwarder lambda function should run in the VPC."
  type        = list(string)
  default     = null
}

variable "log_forwarder_environment_variables" {
  description = "A map of environment variables for the log forwarder lambda function"
  type        = map(string)
  default     = {}
}

variable "log_forwarder_lambda_tags" {
  description = "A map of tags to apply to the log forwarder lambda function"
  type        = map(string)
  default     = {}
}

variable "log_forwarder_tags" {
  description = "A map of tags to apply to the log forwarder resources"
  type        = map(string)
  default     = {}
}

variable "log_forwarder_log_retention_days" {
  description = "Log forwarder CloudWatch log group retention in days"
  type        = number
  default     = 7
}

# RDS Enhanced Monitoring Forwarder IAM Role
variable "create_rds_em_forwarder_role" {
  description = "Controls whether an IAM role is created for the RDS enhanced monitoring forwarder"
  type        = bool
  default     = true
}

variable "rds_em_forwarder_role_arn" {
  description = "IAM role arn for RDS enhanced monitoring forwarder lambda function to utilize"
  type        = string
  default     = null
}

variable "rds_em_forwarder_role_name" {
  description = "RDS enhanced monitoring forwarder role name"
  type        = string
  default     = ""
}

variable "rds_em_forwarder_use_role_name_prefix" {
  description = "Whether to use unique name beginning with the specified `rds_em_forwarder_role_name` for the RDS enhanced monitoring forwarder role"
  type        = bool
  default     = false
}

variable "rds_em_forwarder_role_path" {
  description = "RDS enhanced monitoring forwarder role path"
  type        = string
  default     = null
}

variable "rds_em_forwarder_role_max_session_duration" {
  description = "The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
  type        = number
  default     = null
}

variable "rds_em_forwarder_role_permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the RDS enhanced monitoring forwarder role"
  type        = string
  default     = null
}

variable "rds_em_forwarder_role_tags" {
  description = "A map of tags to apply to the RDS enhanced monitoring forwarder role"
  type        = map(string)
  default     = {}
}

variable "create_rds_em_forwarder_role_policy" {
  description = "Controls whether an IAM role policy is created for the RDS enhanced monitoring forwarder"
  type        = bool
  default     = true
}

variable "rds_em_forwarder_policy_arn" {
  description = "IAM policy arn for RDS enhanced monitoring forwarder lambda function to utilize"
  type        = string
  default     = null
}

variable "rds_em_forwarder_policy_name" {
  description = "RDS enhanced monitoring forwarder policy name"
  type        = string
  default     = ""
}

variable "rds_em_forwarder_use_policy_name_prefix" {
  description = "Whether to use unique name beginning with the specified `rds_em_forwarder_policy_name` for the RDS enhanced monitoring forwarder role"
  type        = bool
  default     = false
}

variable "rds_em_forwarder_policy_path" {
  description = "RDS enhanced monitoring forwarder policy path"
  type        = string
  default     = null
}

# RDS Enhanced Monitoring Lambda Function
variable "rds_em_forwarder_version" {
  description = "RDS enhanced monitoring lambda version - see https://github.com/DataDog/datadog-serverless-functions/releases"
  type        = string
  default     = "3.37.0"
}

variable "create_rds_em_forwarder" {
  description = "Controls whether RDS enhanced monitoring forwarder resources should be created"
  type        = bool
  default     = true
}

variable "rds_em_forwarder_name" {
  description = "RDS enhanced monitoring forwarder lambda name"
  type        = string
  default     = "datadog-rds-enhanced-monitoring-forwarder"
}

variable "rds_em_forwarder_runtime" {
  description = "Lambda function runtime"
  type        = string
  default     = "python3.7"
}

variable "rds_em_forwarder_layers" {
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to the RDS enhanced monitoring forwarder lambda"
  type        = list(string)
  default     = []
}

variable "rds_em_forwarder_memory_size" {
  description = "Memory size for the RDS enhanced monitoring forwarder lambda function"
  type        = number
  default     = 256
}

variable "rds_em_forwarder_timeout" {
  description = "The amount of time the RDS enhanced monitoring forwarder lambda has to execute in seconds"
  type        = number
  default     = 10
}

variable "rds_em_forwarder_publish" {
  description = "Whether to publish creation/change as a new fambda function Version"
  type        = bool
  default     = false
}

variable "rds_em_forwarder_reserved_concurrent_executions" {
  description = "The amount of reserved concurrent executions for the RDS enhanced monitoring forwarder lambda function"
  type        = number
  default     = 10
}

variable "rds_em_forwarder_kms_key_arn" {
  description = "KMS key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key"
  type        = string
  default     = null
}

variable "rds_em_forwarder_subnet_ids" {
  description = "List of subnet ids when forwarder lambda function should run in the VPC. Usually private or intra subnets."
  type        = list(string)
  default     = null
}

variable "rds_em_forwarder_security_group_ids" {
  description = "List of security group ids when forwarder lambda function should run in the VPC."
  type        = list(string)
  default     = null
}

variable "rds_em_forwarder_environment_variables" {
  description = "A map of environment variables for the RDS enhanced monitoring forwarder lambda function"
  type        = map(string)
  default     = {}
}

variable "rds_em_forwarder_lambda_tags" {
  description = "A map of tags to apply to the RDS enhanced monitoring forwarder lambda function"
  type        = map(string)
  default     = {}
}

variable "rds_em_forwarder_tags" {
  description = "A map of tags to apply to the RDS enhanced monitoring forwarder resources"
  type        = map(string)
  default     = {}
}

variable "rds_em_forwarder_log_retention_days" {
  description = "RDS enhanced monitoring forwarder CloudWatch log group retention in days"
  type        = number
  default     = 7
}

# VPC Flow Log Forwarder IAM Role
variable "create_vpc_fl_forwarder_role" {
  description = "Controls whether an IAM role is created for the VPC flow log forwarder"
  type        = bool
  default     = true
}

variable "vpc_fl_forwarder_role_arn" {
  description = "IAM role arn for VPC flow log forwarder lambda function to utilize"
  type        = string
  default     = null
}

variable "vpc_fl_forwarder_role_name" {
  description = "VPC flow log forwarder role name"
  type        = string
  default     = ""
}

variable "vpc_fl_forwarder_use_role_name_prefix" {
  description = "Whether to use unique name beginning with the specified `vpc_fl_forwarder_role_name` for the VPC flow log forwarder role"
  type        = bool
  default     = false
}

variable "vpc_fl_forwarder_role_path" {
  description = "VPC flow log forwarder role path"
  type        = string
  default     = null
}

variable "vpc_fl_forwarder_role_max_session_duration" {
  description = "The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
  type        = number
  default     = null
}

variable "vpc_fl_forwarder_role_permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the VPC flow log forwarder role"
  type        = string
  default     = null
}

variable "vpc_fl_forwarder_role_tags" {
  description = "A map of tags to apply to the VPC flow log forwarder role"
  type        = map(string)
  default     = {}
}

variable "create_vpc_fl_forwarder_role_policy" {
  description = "Controls whether an IAM role policy is created for the VPC flow log forwarder"
  type        = bool
  default     = true
}

variable "vpc_fl_forwarder_policy_arn" {
  description = "IAM policy arn for VPC flow log forwarder lambda function to utilize"
  type        = string
  default     = null
}

variable "vpc_fl_forwarder_policy_name" {
  description = "VPC flow log forwarder policy name"
  type        = string
  default     = ""
}

variable "vpc_fl_forwarder_use_policy_name_prefix" {
  description = "Whether to use unique name beginning with the specified `vpc_fl_forwarder_policy_name` for the VPC flow log forwarder role"
  type        = bool
  default     = false
}

variable "vpc_fl_forwarder_policy_path" {
  description = "VPC flow log forwarder policy path"
  type        = string
  default     = null
}

variable "vpc_fl_forwarder_s3_log_bucket_arns" {
  description = "S3 log buckets for VPC flow log forwarder to read and forward to Datadog"
  type        = list(string)
  default     = []
}

variable "vpc_fl_forwarder_read_cloudwatch_logs" {
  description = "Whether the VPC flow log forwarder will read CloudWatch log groups for VPC flow logs"
  type        = bool
  default     = false
}

# VPC Flow Log Forwarder Lambda Function
variable "vpc_fl_forwarder_version" {
  description = "VPC flow log lambda version - see https://github.com/DataDog/datadog-serverless-functions/releases"
  type        = string
  default     = "3.37.0"
}

variable "create_vpc_fl_forwarder" {
  description = "Controls whether VPC flow log forwarder resources should be created"
  type        = bool
  default     = true
}

variable "vpc_fl_forwarder_name" {
  description = "VPC flow log forwarder lambda name"
  type        = string
  default     = "datadog-vpc-flow-log-forwarder"
}

variable "vpc_fl_forwarder_runtime" {
  description = "Lambda function runtime"
  type        = string
  default     = "python3.7"
}

variable "vpc_fl_forwarder_layers" {
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to the VPC flow log forwarder lambda"
  type        = list(string)
  default     = []
}

variable "vpc_fl_forwarder_memory_size" {
  description = "Memory size for the VPC flow log forwarder lambda function"
  type        = number
  default     = 256
}

variable "vpc_fl_forwarder_timeout" {
  description = "The amount of time the VPC flow log forwarder lambda has to execute in seconds"
  type        = number
  default     = 10
}

variable "vpc_fl_forwarder_publish" {
  description = "Whether to publish creation/change as a new fambda function Version"
  type        = bool
  default     = false
}

variable "vpc_fl_forwarder_reserved_concurrent_executions" {
  description = "The amount of reserved concurrent executions for the VPC flow log forwarder lambda function"
  type        = number
  default     = 10
}

variable "vpc_fl_forwarder_kms_key_arn" {
  description = "KMS key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key"
  type        = string
  default     = null
}

variable "vpc_fl_forwarder_subnet_ids" {
  description = "List of subnet ids when forwarder lambda function should run in the VPC. Usually private or intra subnets."
  type        = list(string)
  default     = null
}

variable "vpc_fl_forwarder_security_group_ids" {
  description = "List of security group ids when forwarder lambda function should run in the VPC."
  type        = list(string)
  default     = null
}

variable "vpc_fl_forwarder_environment_variables" {
  description = "A map of environment variables for the VPC flow log forwarder lambda function"
  type        = map(string)
  default     = {}
}

variable "vpc_fl_forwarder_lambda_tags" {
  description = "A map of tags to apply to the VPC flow log forwarder lambda function"
  type        = map(string)
  default     = {}
}

variable "vpc_fl_forwarder_tags" {
  description = "A map of tags to apply to the VPC flow log forwarder resources"
  type        = map(string)
  default     = {}
}

variable "vpc_fl_forwarder_log_retention_days" {
  description = "VPC flow log forwarder CloudWatch log group retention in days"
  type        = number
  default     = 7
}

# PrivateLink / VPC Endpoints
variable "vpc_id" {
  description = "ID of VPC to provision endpoints within"
  type        = string
  default     = null
}

variable "create_metrics_vpce" {
  description = "Controls whether a metrics VPC endpoint should be created"
  type        = bool
  default     = false
}

variable "metrics_vpce_subnet_ids" {
  description = "IDs of subnets to associate with metrics endpoint"
  type        = list(string)
  default     = []
}

variable "metrics_vpce_security_group_ids" {
  description = "IDs of security groups to attach to metrics endpoint"
  type        = list(string)
  default     = []
}

variable "metrics_vpce_policy" {
  description = "Policy to attach to the metrics endpoint that controls access to the service. Defaults to full access"
  type        = any
  default     = null
}

variable "metrics_vpce_tags" {
  description = "A map of tags to apply to the metrics endpoint"
  type        = map(string)
  default     = {}
}

variable "create_agent_vpce" {
  description = "Controls whether an agent endpoint should be created"
  type        = bool
  default     = false
}

variable "agent_vpce_subnet_ids" {
  description = "IDs of subnets to associate with agent endpoint"
  type        = list(string)
  default     = []
}

variable "agent_vpce_security_group_ids" {
  description = "IDs of security groups to attach to agent endpoint"
  type        = list(string)
  default     = []
}

variable "agent_vpce_policy" {
  description = "Policy to attach to the agent endpoint that controls access to the service. Defaults to full access"
  type        = any
  default     = null
}

variable "agent_vpce_tags" {
  description = "A map of tags to apply to the Datadog agent endpoint"
  type        = map(string)
  default     = {}
}

variable "create_log_forwarder_vpce" {
  description = "Controls whether a log forwarder endpoint should be created"
  type        = bool
  default     = false
}

variable "log_forwarder_vpce_subnet_ids" {
  description = "IDs of subnets to associate with log forwarder endpoint"
  type        = list(string)
  default     = []
}

variable "log_forwarder_vpce_security_group_ids" {
  description = "IDs of security groups to attach to log forwarder endpoint"
  type        = list(string)
  default     = []
}

variable "log_forwarder_vpce_policy" {
  description = "Policy to attach to the log forwarder endpoint that controls access to the service. Defaults to full access"
  type        = any
  default     = null
}

variable "log_forwarder_vpce_tags" {
  description = "A map of tags to apply to the log forwarder endpoint"
  type        = map(string)
  default     = {}
}

variable "create_api_vpce" {
  description = "Controls whether a API endpoint should be created"
  type        = bool
  default     = false
}

variable "api_vpce_subnet_ids" {
  description = "IDs of subnets to associate with API endpoint"
  type        = list(string)
  default     = []
}

variable "api_vpce_security_group_ids" {
  description = "IDs of security groups to attach to API endpoint"
  type        = list(string)
  default     = []
}

variable "api_vpce_policy" {
  description = "Policy to attach to the API endpoint that controls access to the service. Defaults to full access"
  type        = any
  default     = null
}

variable "api_vpce_tags" {
  description = "A map of tags to apply to the API endpoint"
  type        = map(string)
  default     = {}
}

variable "create_processes_vpce" {
  description = "Controls whether a processes endpoint should be created"
  type        = bool
  default     = false
}

variable "processes_vpce_subnet_ids" {
  description = "IDs of subnets to associate with processes endpoint"
  type        = list(string)
  default     = []
}

variable "processes_vpce_security_group_ids" {
  description = "IDs of security groups to attach to processes endpoint"
  type        = list(string)
  default     = []
}

variable "processes_vpce_policy" {
  description = "Policy to attach to the processes endpoint that controls access to the service. Defaults to full access"
  type        = any
  default     = null
}

variable "processes_vpce_tags" {
  description = "A map of tags to apply to the processes endpoint"
  type        = map(string)
  default     = {}
}

variable "create_traces_vpce" {
  description = "Controls whether a traces endpoint should be created"
  type        = bool
  default     = false
}

variable "traces_vpce_subnet_ids" {
  description = "IDs of subnets to associate with traces endpoint"
  type        = list(string)
  default     = []
}

variable "traces_vpce_security_group_ids" {
  description = "IDs of security groups to attach to traces endpoint"
  type        = list(string)
  default     = []
}

variable "traces_vpce_policy" {
  description = "Policy to attach to the traces endpoint that controls access to the service. Defaults to full access"
  type        = any
  default     = null
}

variable "traces_vpce_tags" {
  description = "A map of tags to apply to the traces endpoint"
  type        = map(string)
  default     = {}
}
