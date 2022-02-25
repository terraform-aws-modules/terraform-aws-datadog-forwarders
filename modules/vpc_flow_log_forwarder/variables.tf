variable "create" {
  description = "Controls whether the forwarder resources should be created"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to use on all resources"
  type        = map(string)
  default     = {}
}

# Datadog environment Variables
variable "dd_app_key" {
  description = "The Datadog application key associated with the user account that created it, which can be found from the APIs page"
  type        = string
  default     = ""
}

variable "dd_api_key_secret_arn" {
  description = "The ARN of the Secrets Manager secret storing the Datadog API key, if you already have it stored in Secrets Manager"
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

# Forwarder IAM Role
variable "create_role" {
  description = "Controls whether an IAM role is created for the forwarder"
  type        = bool
  default     = true
}

variable "role_arn" {
  description = "IAM role arn for forwarder lambda function to utilize"
  type        = string
  default     = null
}

variable "role_name" {
  description = "Forwarder role name"
  type        = string
  default     = ""
}

variable "use_role_name_prefix" {
  description = "Whether to use unique name beginning with the specified `role_name` for the forwarder role"
  type        = bool
  default     = false
}

variable "role_path" {
  description = "Forwarder role path"
  type        = string
  default     = null
}

variable "role_max_session_duration" {
  description = "The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours"
  type        = number
  default     = null
}

variable "role_permissions_boundary" {
  description = "The ARN of the policy that is used to set the permissions boundary for the forwarder role"
  type        = string
  default     = null
}

variable "role_tags" {
  description = "A map of tags to apply to the forwarder role"
  type        = map(string)
  default     = {}
}

variable "create_role_policy" {
  description = "Controls whether an IAM role policy is created for the forwarder"
  type        = bool
  default     = true
}

variable "policy_arn" {
  description = "IAM policy arn for forwarder lambda function to utilize"
  type        = string
  default     = null
}

variable "policy_name" {
  description = "Forwarder policy name"
  type        = string
  default     = ""
}

variable "use_policy_name_prefix" {
  description = "Whether to use unique name beginning with the specified `policy_name` for the forwarder policy"
  type        = bool
  default     = false
}

variable "policy_path" {
  description = "Forwarder policy path"
  type        = string
  default     = null
}

variable "s3_log_bucket_arns" {
  description = "S3 log buckets for forwarder to read and forward VPC flow logs to Datadog"
  type        = list(string)
  default     = []
}

variable "read_cloudwatch_logs" {
  description = "Whether the forwarder will read CloudWatch log groups for VPC flow logs"
  type        = bool
  default     = false
}

# Forwarder Lambda Function
variable "forwarder_version" {
  description = "VPC flow log monitoring version - see https://github.com/DataDog/datadog-serverless-functions/releases"
  type        = string
  default     = "3.42.0"
}

variable "name" {
  description = "Forwarder lambda name"
  type        = string
  default     = "datadog-vpc-flow-log-forwarder"
}

variable "runtime" {
  description = "Lambda function runtime"
  type        = string
  default     = "python3.9"
}

variable "layers" {
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to the forwarder lambda"
  type        = list(string)
  default     = []
}

variable "memory_size" {
  description = "Memory size for the forwarder lambda function"
  type        = number
  default     = 256
}

variable "timeout" {
  description = "The amount of time the forwarder lambda has to execute in seconds"
  type        = number
  default     = 10
}

variable "publish" {
  description = "Whether to publish creation/change as a new Lambda Function Version"
  type        = bool
  default     = false
}

variable "architectures" {
  description = "Instruction set architecture for your Lambda function. Valid values are `[\"x86_64\"]` and `[\"arm64\"]`. Default is `[\"x86_64\"]`"
  type        = list(string)
  default     = ["x86_64"]
}

variable "reserved_concurrent_executions" {
  description = "The amount of reserved concurrent executions for the forwarder lambda function"
  type        = number
  default     = 10
}

variable "kms_key_arn" {
  description = "KMS key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of subnet ids when Lambda Function should run in the VPC. Usually private or intra subnets"
  type        = list(string)
  default     = null
}

variable "security_group_ids" {
  description = "List of security group ids when Lambda Function should run in the VPC"
  type        = list(string)
  default     = null
}

variable "environment_variables" {
  description = "A map of environment variables for the forwarder lambda function"
  type        = map(string)
  default     = {}
}

variable "lambda_tags" {
  description = "A map of tags to apply to the forwarder lambda function"
  type        = map(string)
  default     = {}
}

variable "log_retention_days" {
  description = "Forwarder CloudWatch log group retention in days"
  type        = number
  default     = 7
}
