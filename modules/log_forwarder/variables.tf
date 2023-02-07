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
variable "dd_api_key" {
  description = "The Datadog API key, which can be found from the APIs page (/account/settings#api). It will be stored in AWS Secrets Manager securely"
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

# S3 Forwarder Bucket
variable "create_bucket" {
  description = "Controls whether an S3 bucket should be created for the forwarder"
  type        = bool
  default     = true
}

variable "bucket_name" {
  description = "Forwarder S3 bucket name"
  type        = string
  default     = ""
}

variable "bucket_attach_deny_insecure_transport_policy" {
  description = "Controls if S3 bucket should have deny non-SSL transport policy attacheds"
  type        = bool
  default     = false
}

variable "bucket_encryption_settings" {
  description = "S3 bucket server side encryption settings"
  type        = map(string)
  default = {
    sse_algorithm = "AES256"
  }
}

# Forwarder S3 Zip Objcet
variable "bucket_prefix" {
  description = "S3 object key prefix to prepend to zip archive name"
  type        = string
  default     = ""
}

variable "s3_zip_storage_class" {
  description = "Specifies the desired Storage Class for the zip object. Can be either `STANDARD`, `REDUCED_REDUNDANCY`, `ONEZONE_IA`, `INTELLIGENT_TIERING`, or `STANDARD_IA`"
  type        = string
  default     = null
}

variable "s3_zip_server_side_encryption" {
  description = "Server-side encryption of the zip object in S3. Valid values are `AES256` and `aws:kms`"
  type        = string
  default     = null
}

variable "s3_zip_kms_key_id" {
  description = "The AWS KMS Key ARN to use for object encryption"
  type        = string
  default     = null
}

variable "s3_zip_metadata" {
  description = "A map of keys/values to provision metadata (will be automatically prefixed by `x-amz-meta-`"
  type        = map(string)
  default     = {}
}

variable "s3_zip_tags" {
  description = "A map of tags to apply to the zip archive in S3"
  type        = map(string)
  default     = {}
  validation {
    condition     = length(var.s3_zip_tags) <= 10
    error_message = "You can associate up to 10 tags with an s3 bucket object."
  }
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
  description = "S3 log buckets for forwarder to read and forward logs to Datadog"
  type        = list(string)
  default     = []
}

# Forwarder Lambda Function
variable "forwarder_version" {
  description = "Forwarder version - see https://github.com/DataDog/datadog-serverless-functions/releases"
  type        = string
  default     = "3.69.0"
}

variable "name" {
  description = "Forwarder lambda name"
  type        = string
  default     = "datadog-log-forwarder"
}

variable "runtime" {
  description = "Lambda function runtime"
  type        = string
  default     = "python3.7"
}

variable "layers" {
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to the forwarder lambda"
  type        = list(string)
  default     = []
}

variable "memory_size" {
  description = "Memory size for the forwarder lambda function"
  type        = number
  default     = 1024
}

variable "timeout" {
  description = "The amount of time the forwarder lambda has to execute in seconds"
  type        = number
  default     = 120
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
  default     = 100
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
