# AWS Datadog Log Forwarder Terraform module

Terraform module which creates Datadog log forwarder resources on AWS.

> The Datadog log forwarder is an AWS Lambda function that ships logs, custom metrics, and traces from your environment to Datadog. The Forwarder can:
>
> - Forward CloudWatch, ELB, S3, CloudTrail, VPC, SNS, and CloudFront logs to Datadog
> - Forward S3 events to Datadog
> - Forward Kinesis data stream events to Datadog (only CloudWatch logs are supported)
> - Forward custom metrics from AWS Lambda functions using CloudWatch logs
> - Forward traces from AWS Lambda functions using CloudWatch logs
> - Generate and submit enhanced Lambda metrics (`aws.lambda.enhanced.*`) parsed from the AWS REPORT log: duration, billed_duration, max_memory_used, timeouts, out_of_memory, and estimated_cost
>
> For additional information on sending AWS services logs with the Datadog Forwarder, see [here](https://docs.datadoghq.com/logs/guide/send-aws-services-logs-with-the-datadog-lambda-function/).

Taken from: [`datadog-serverless-functions/aws/log_monitoring`](https://github.com/DataDog/datadog-serverless-functions/blob/master/aws/logs_monitoring/README.md)

## Usage

```hcl
# Note: you will need to create this secret manually prior to running
# This avoids having to pass the key to Terraform in plaintext
data "aws_secretsmanager_secret" "datadog_api_key" {
  name = "datadog/api_key"
}

module "datadog_log_forwarder" {
  source  = "clowdhaus/datadog-forwarders/aws//modules/log_forwarder"

  dd_api_key_secret_arn = data.aws_secretsmanager_secret.datadog_api_key.arn

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this_s3_bucket"></a> [this\_s3\_bucket](#module\_this\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | v2.14.1 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_lambda_permission.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket_object.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [null_resource.this](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_architectures"></a> [architectures](#input\_architectures) | Instruction set architecture for your Lambda function. Valid values are `["x86_64"]` and `["arm64"]`. Default is `["x86_64"]` | `list(string)` | <pre>[<br>  "x86_64"<br>]</pre> | no |
| <a name="input_bucket_attach_deny_insecure_transport_policy"></a> [bucket\_attach\_deny\_insecure\_transport\_policy](#input\_bucket\_attach\_deny\_insecure\_transport\_policy) | Controls if S3 bucket should have deny non-SSL transport policy attacheds | `bool` | `false` | no |
| <a name="input_bucket_encryption_settings"></a> [bucket\_encryption\_settings](#input\_bucket\_encryption\_settings) | S3 bucket server side encryption settings | `map(string)` | <pre>{<br>  "sse_algorithm": "AES256"<br>}</pre> | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Forwarder S3 bucket name | `string` | `""` | no |
| <a name="input_bucket_prefix"></a> [bucket\_prefix](#input\_bucket\_prefix) | S3 object key prefix to prepend to zip archive name | `string` | `""` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls whether the forwarder resources should be created | `bool` | `true` | no |
| <a name="input_create_bucket"></a> [create\_bucket](#input\_create\_bucket) | Controls whether an S3 bucket should be created for the forwarder | `bool` | `true` | no |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | Controls whether an IAM role is created for the forwarder | `bool` | `true` | no |
| <a name="input_create_role_policy"></a> [create\_role\_policy](#input\_create\_role\_policy) | Controls whether an IAM role policy is created for the forwarder | `bool` | `true` | no |
| <a name="input_dd_api_key"></a> [dd\_api\_key](#input\_dd\_api\_key) | The Datadog API key, which can be found from the APIs page (/account/settings#api). It will be stored in AWS Secrets Manager securely | `string` | `""` | no |
| <a name="input_dd_api_key_secret_arn"></a> [dd\_api\_key\_secret\_arn](#input\_dd\_api\_key\_secret\_arn) | The ARN of the Secrets Manager secret storing the Datadog API key, if you already have it stored in Secrets Manager | `string` | `""` | no |
| <a name="input_dd_site"></a> [dd\_site](#input\_dd\_site) | Define your Datadog Site to send data to. For the Datadog EU site, set to datadoghq.eu | `string` | `"datadoghq.com"` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | A map of environment variables for the forwarder lambda function | `map(string)` | `{}` | no |
| <a name="input_forwarder_version"></a> [forwarder\_version](#input\_forwarder\_version) | Forwarder version - see https://github.com/DataDog/datadog-serverless-functions/releases | `string` | `"3.42.0"` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | KMS key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key | `string` | `null` | no |
| <a name="input_lambda_tags"></a> [lambda\_tags](#input\_lambda\_tags) | A map of tags to apply to the forwarder lambda function | `map(string)` | `{}` | no |
| <a name="input_layers"></a> [layers](#input\_layers) | List of Lambda Layer Version ARNs (maximum of 5) to attach to the forwarder lambda | `list(string)` | `[]` | no |
| <a name="input_log_retention_days"></a> [log\_retention\_days](#input\_log\_retention\_days) | Forwarder CloudWatch log group retention in days | `number` | `7` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Memory size for the forwarder lambda function | `number` | `1024` | no |
| <a name="input_name"></a> [name](#input\_name) | Forwarder lambda name | `string` | `"datadog-log-forwarder"` | no |
| <a name="input_policy_arn"></a> [policy\_arn](#input\_policy\_arn) | IAM policy arn for forwarder lambda function to utilize | `string` | `null` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Forwarder policy name | `string` | `""` | no |
| <a name="input_policy_path"></a> [policy\_path](#input\_policy\_path) | Forwarder policy path | `string` | `null` | no |
| <a name="input_publish"></a> [publish](#input\_publish) | Whether to publish creation/change as a new Lambda Function Version | `bool` | `false` | no |
| <a name="input_reserved_concurrent_executions"></a> [reserved\_concurrent\_executions](#input\_reserved\_concurrent\_executions) | The amount of reserved concurrent executions for the forwarder lambda function | `number` | `100` | no |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | IAM role arn for forwarder lambda function to utilize | `string` | `null` | no |
| <a name="input_role_max_session_duration"></a> [role\_max\_session\_duration](#input\_role\_max\_session\_duration) | The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours | `number` | `null` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Forwarder role name | `string` | `""` | no |
| <a name="input_role_path"></a> [role\_path](#input\_role\_path) | Forwarder role path | `string` | `null` | no |
| <a name="input_role_permissions_boundary"></a> [role\_permissions\_boundary](#input\_role\_permissions\_boundary) | The ARN of the policy that is used to set the permissions boundary for the forwarder role | `string` | `null` | no |
| <a name="input_role_tags"></a> [role\_tags](#input\_role\_tags) | A map of tags to apply to the forwarder role | `map(string)` | `{}` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Lambda function runtime | `string` | `"python3.9"` | no |
| <a name="input_s3_log_bucket_arns"></a> [s3\_log\_bucket\_arns](#input\_s3\_log\_bucket\_arns) | S3 log buckets for forwarder to read and forward logs to Datadog | `list(string)` | `[]` | no |
| <a name="input_s3_zip_kms_key_id"></a> [s3\_zip\_kms\_key\_id](#input\_s3\_zip\_kms\_key\_id) | The AWS KMS Key ARN to use for object encryption | `string` | `null` | no |
| <a name="input_s3_zip_metadata"></a> [s3\_zip\_metadata](#input\_s3\_zip\_metadata) | A map of keys/values to provision metadata (will be automatically prefixed by `x-amz-meta-` | `map(string)` | `{}` | no |
| <a name="input_s3_zip_server_side_encryption"></a> [s3\_zip\_server\_side\_encryption](#input\_s3\_zip\_server\_side\_encryption) | Server-side encryption of the zip object in S3. Valid values are `AES256` and `aws:kms` | `string` | `null` | no |
| <a name="input_s3_zip_storage_class"></a> [s3\_zip\_storage\_class](#input\_s3\_zip\_storage\_class) | Specifies the desired Storage Class for the zip object. Can be either `STANDARD`, `REDUCED_REDUNDANCY`, `ONEZONE_IA`, `INTELLIGENT_TIERING`, or `STANDARD_IA` | `string` | `null` | no |
| <a name="input_s3_zip_tags"></a> [s3\_zip\_tags](#input\_s3\_zip\_tags) | A map of tags to apply to the zip archive in S3 | `map(string)` | `{}` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of security group ids when Lambda Function should run in the VPC | `list(string)` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet ids when Lambda Function should run in the VPC. Usually private or intra subnets | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to use on all resources | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | The amount of time the forwarder lambda has to execute in seconds | `number` | `120` | no |
| <a name="input_use_policy_name_prefix"></a> [use\_policy\_name\_prefix](#input\_use\_policy\_name\_prefix) | Whether to use unique name beginning with the specified `policy_name` for the forwarder policy | `bool` | `false` | no |
| <a name="input_use_role_name_prefix"></a> [use\_role\_name\_prefix](#input\_use\_role\_name\_prefix) | Whether to use unique name beginning with the specified `role_name` for the forwarder role | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_log_group_arn"></a> [cloudwatch\_log\_group\_arn](#output\_cloudwatch\_log\_group\_arn) | The ARN of the forwarder lambda function CloudWatch log group |
| <a name="output_lambda_arn"></a> [lambda\_arn](#output\_lambda\_arn) | The ARN of the forwarder lambda function |
| <a name="output_lambda_kms_key_arn"></a> [lambda\_kms\_key\_arn](#output\_lambda\_kms\_key\_arn) | (Optional) The ARN for the KMS encryption key for the forwarder lambda function |
| <a name="output_lambda_qualified_arn"></a> [lambda\_qualified\_arn](#output\_lambda\_qualified\_arn) | The ARN of the forwarder lambda function (if versioning is enabled via publish = true) |
| <a name="output_lambda_source_code_hash"></a> [lambda\_source\_code\_hash](#output\_lambda\_source\_code\_hash) | Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3\_* parameters |
| <a name="output_lambda_version"></a> [lambda\_version](#output\_lambda\_version) | Latest published version of the forwarder lambda function |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | The forwarder lambda role arn |
| <a name="output_role_id"></a> [role\_id](#output\_role\_id) | The forwarder lambda role id |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | The forwarder lambda role name |
| <a name="output_role_policy_arn"></a> [role\_policy\_arn](#output\_role\_policy\_arn) | The ARN of the forwarder lambda role policy |
| <a name="output_role_policy_id"></a> [role\_policy\_id](#output\_role\_policy\_id) | The ID of the forwarder lambda role policy |
| <a name="output_role_policy_name"></a> [role\_policy\_name](#output\_role\_policy\_name) | The name of the forwarder lambda role policy |
| <a name="output_role_unique_id"></a> [role\_unique\_id](#output\_role\_unique\_id) | The stable and unique string identifying the forwarder lambda role |
| <a name="output_s3_bucket_arn"></a> [s3\_bucket\_arn](#output\_s3\_bucket\_arn) | The ARN of the bucket. Will be of format arn:aws:s3:::bucketname |
| <a name="output_s3_bucket_domain_name"></a> [s3\_bucket\_domain\_name](#output\_s3\_bucket\_domain\_name) | The bucket domain name. Will be of format bucketname.s3.amazonaws.com |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | The name of the bucket |
| <a name="output_s3_bucket_regional_domain_name"></a> [s3\_bucket\_regional\_domain\_name](#output\_s3\_bucket\_regional\_domain\_name) | The bucket region-specific domain name. The bucket domain name including the region name |
| <a name="output_s3_object_etag"></a> [s3\_object\_etag](#output\_s3\_object\_etag) | The ETag generated for the forwarder lambda zip object (an MD5 sum of the object content) |
| <a name="output_s3_object_id"></a> [s3\_object\_id](#output\_s3\_object\_id) | The `key` of the forwarder lambda zip archive |
| <a name="output_s3_object_version"></a> [s3\_object\_version](#output\_s3\_object\_version) | A unique version ID value for the forwarder lambda zip object, if bucket versioning is enabled |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed. See [LICENSE](../../LICENSE).
