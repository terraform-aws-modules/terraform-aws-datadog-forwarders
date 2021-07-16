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
  value       = element(concat(aws_iam_role.this.*.arn, [""]), 0)
}

output "role_id" {
  description = "The forwarder lambda role id"
  value       = element(concat(aws_iam_role.this.*.id, [""]), 0)
}

output "role_name" {
  description = "The forwarder lambda role name"
  value       = element(concat(aws_iam_role.this.*.name, [""]), 0)
}

output "role_unique_id" {
  description = "The stable and unique string identifying the forwarder lambda role"
  value       = element(concat(aws_iam_role.this.*.unique_id, [""]), 0)
}

output "role_policy_arn" {
  description = "The ARN of the forwarder lambda role policy"
  value       = element(concat(aws_iam_policy.this.*.arn, [""]), 0)
}

output "role_policy_id" {
  description = "The ID of the forwarder lambda role policy"
  value       = element(concat(aws_iam_policy.this.*.id, [""]), 0)
}

output "role_policy_name" {
  description = "The name of the forwarder lambda role policy"
  value       = element(concat(aws_iam_policy.this.*.name, [""]), 0)
}

# Forwarder ZIP Archive
output "s3_object_id" {
  description = "The `key` of the forwarder lambda zip archive"
  value       = element(concat(aws_s3_bucket_object.this.*.id, [""]), 0)
}

output "s3_object_etag" {
  description = "The ETag generated for the forwarder lambda zip object (an MD5 sum of the object content)"
  value       = element(concat(aws_s3_bucket_object.this.*.etag, [""]), 0)
}

output "s3_object_version" {
  description = "A unique version ID value for the forwarder lambda zip object, if bucket versioning is enabled"
  value       = element(concat(aws_s3_bucket_object.this.*.version_id, [""]), 0)
}

# Forwarder Lambda Function
output "lambda_arn" {
  description = "The ARN of the forwarder lambda function"
  value       = element(concat(aws_lambda_function.this.*.arn, [""]), 0)
}

output "lambda_qualified_arn" {
  description = "The ARN of the forwarder lambda function (if versioning is enabled via publish = true)"
  value       = element(concat(aws_lambda_function.this.*.qualified_arn, [""]), 0)
}

output "lambda_version" {
  description = "Latest published version of the forwarder lambda function"
  value       = element(concat(aws_lambda_function.this.*.version, [""]), 0)
}

output "lambda_kms_key_arn" {
  description = "(Optional) The ARN for the KMS encryption key for the forwarder lambda function"
  value       = element(concat(aws_lambda_function.this.*.kms_key_arn, [""]), 0)
}

output "lambda_source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3_* parameters"
  value       = element(concat(aws_lambda_function.this.*.source_code_hash, [""]), 0)
}

# Forwarder CloudWatch Logs
output "cloudwatch_log_group_arn" {
  description = "The ARN of the forwarder lambda function CloudWatch log group"
  value       = element(concat(aws_cloudwatch_log_group.this.*.arn, [""]), 0)
}
