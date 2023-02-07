# Forwarder bucket
output "s3_bucket_id" {
  description = "The name of the bucket"
  value       = module.this_s3_bucket.s3_bucket_id
}

output "s3_bucket_arn" {
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname"
  value       = module.this_s3_bucket.s3_bucket_arn
}

output "s3_bucket_domain_name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com"
  value       = module.this_s3_bucket.s3_bucket_bucket_domain_name
}

output "s3_bucket_regional_domain_name" {
  description = "The bucket region-specific domain name. The bucket domain name including the region name"
  value       = module.this_s3_bucket.s3_bucket_bucket_regional_domain_name
}

# Forwarder role
output "role_arn" {
  description = "The forwarder lambda role arn"
  value       = try(aws_iam_role.this[0].arn, "")
}

output "role_id" {
  description = "The forwarder lambda role id"
  value       = try(aws_iam_role.this[0].id, "")
}

output "role_name" {
  description = "The forwarder lambda role name"
  value       = try(aws_iam_role.this[0].name, "")
}

output "role_unique_id" {
  description = "The stable and unique string identifying the forwarder lambda role"
  value       = try(aws_iam_role.this[0].unique_id, "")
}

output "role_policy_arn" {
  description = "The ARN of the forwarder lambda role policy"
  value       = try(aws_iam_policy.this[0].arn, "")
}

output "role_policy_id" {
  description = "The ID of the forwarder lambda role policy"
  value       = try(aws_iam_policy.this[0].id, "")
}

output "role_policy_name" {
  description = "The name of the forwarder lambda role policy"
  value       = try(aws_iam_policy.this[0].name, "")
}

# Forwarder ZIP Archive
output "s3_object_id" {
  description = "The `key` of the forwarder lambda zip archive"
  value       = try(aws_s3_object.this[0].id, "")
}

output "s3_object_etag" {
  description = "The ETag generated for the forwarder lambda zip object (an MD5 sum of the object content)"
  value       = try(aws_s3_object.this[0].etag, "")
}

output "s3_object_version" {
  description = "A unique version ID value for the forwarder lambda zip object, if bucket versioning is enabled"
  value       = try(aws_s3_object.this[0].version_id, "")
}

# Forwarder Lambda Function
output "lambda_arn" {
  description = "The ARN of the forwarder lambda function"
  value       = try(aws_lambda_function.this[0].arn, "")
}

output "lambda_qualified_arn" {
  description = "The ARN of the forwarder lambda function (if versioning is enabled via publish = true)"
  value       = try(aws_lambda_function.this[0].qualified_arn, "")
}

output "lambda_version" {
  description = "Latest published version of the forwarder lambda function"
  value       = try(aws_lambda_function.this[0].version, "")
}

output "lambda_kms_key_arn" {
  description = "(Optional) The ARN for the KMS encryption key for the forwarder lambda function"
  value       = try(aws_lambda_function.this[0].kms_key_arn, "")
}

output "lambda_source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3_* parameters"
  value       = try(aws_lambda_function.this[0].source_code_hash, "")
}

# Forwarder CloudWatch Logs
output "cloudwatch_log_group_arn" {
  description = "The ARN of the forwarder lambda function CloudWatch log group"
  value       = try(aws_cloudwatch_log_group.this[0].arn, "")
}
