# Simple example

Configuration in this directory creates the log forwarder, RDS enhanced monitoring forwarder, and VPC flow log forwarder with their default configurations.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which will incur monetary charges on your AWS bill. Run `terraform destroy` when you no longer need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_default"></a> [default](#module\_default) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.datadog](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.datadog](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [random_pet.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.datadog_cmk](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_secretsmanager_secret.datadog_api_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_log_forwarder_cloudwatch_log_group_arn"></a> [log\_forwarder\_cloudwatch\_log\_group\_arn](#output\_log\_forwarder\_cloudwatch\_log\_group\_arn) | The ARN of the log forwarder lambda function CloudWatch log group |
| <a name="output_log_forwarder_lambda_arn"></a> [log\_forwarder\_lambda\_arn](#output\_log\_forwarder\_lambda\_arn) | The ARN of the log forwarder lambda function |
| <a name="output_log_forwarder_lambda_qualified_arn"></a> [log\_forwarder\_lambda\_qualified\_arn](#output\_log\_forwarder\_lambda\_qualified\_arn) | The ARN of the log forwarder lambda function (if versioning is enabled via publish = true) |
| <a name="output_log_forwarder_lambda_source_code_hash"></a> [log\_forwarder\_lambda\_source\_code\_hash](#output\_log\_forwarder\_lambda\_source\_code\_hash) | Base64-encoded representation of raw SHA-256 sum of the log forwarder zip file, provided either via filename or s3\_* parameters |
| <a name="output_log_forwarder_role_arn"></a> [log\_forwarder\_role\_arn](#output\_log\_forwarder\_role\_arn) | The log forwarder lambda role arn |
| <a name="output_log_forwarder_role_name"></a> [log\_forwarder\_role\_name](#output\_log\_forwarder\_role\_name) | The log forwarder lambda role name |
| <a name="output_log_forwarder_role_policy_arn"></a> [log\_forwarder\_role\_policy\_arn](#output\_log\_forwarder\_role\_policy\_arn) | The ARN of the log forwarder lambda role policy |
| <a name="output_log_forwarder_role_policy_name"></a> [log\_forwarder\_role\_policy\_name](#output\_log\_forwarder\_role\_policy\_name) | The name of the log forwarder lambda role policy |
| <a name="output_log_forwarder_s3_bucket_arn"></a> [log\_forwarder\_s3\_bucket\_arn](#output\_log\_forwarder\_s3\_bucket\_arn) | The ARN of the log forwarder bucket. Will be of format arn:aws:s3:::bucketname |
| <a name="output_log_forwarder_s3_bucket_domain_name"></a> [log\_forwarder\_s3\_bucket\_domain\_name](#output\_log\_forwarder\_s3\_bucket\_domain\_name) | The log forwarder bucket domain name. Will be of format bucketname.s3.amazonaws.com |
| <a name="output_log_forwarder_s3_bucket_regional_domain_name"></a> [log\_forwarder\_s3\_bucket\_regional\_domain\_name](#output\_log\_forwarder\_s3\_bucket\_regional\_domain\_name) | The log forwarder bucket region-specific domain name. The bucket domain name including the region name |
| <a name="output_log_forwarder_s3_object_id"></a> [log\_forwarder\_s3\_object\_id](#output\_log\_forwarder\_s3\_object\_id) | The `key` of the log forwarder lambda zip archive |
| <a name="output_log_forwarder_s3_object_version"></a> [log\_forwarder\_s3\_object\_version](#output\_log\_forwarder\_s3\_object\_version) | A unique version ID value for the log forwarder lambda zip object, if bucket versioning is enabled |
| <a name="output_rds_em_forwarder_cloudwatch_log_group_arn"></a> [rds\_em\_forwarder\_cloudwatch\_log\_group\_arn](#output\_rds\_em\_forwarder\_cloudwatch\_log\_group\_arn) | The ARN of the RDS enhanced monitoring forwarder lambda function CloudWatch log group |
| <a name="output_rds_em_forwarder_lambda_arn"></a> [rds\_em\_forwarder\_lambda\_arn](#output\_rds\_em\_forwarder\_lambda\_arn) | The ARN of the RDS enhanced monitoring forwarder lambda function |
| <a name="output_rds_em_forwarder_lambda_qualified_arn"></a> [rds\_em\_forwarder\_lambda\_qualified\_arn](#output\_rds\_em\_forwarder\_lambda\_qualified\_arn) | The ARN of the RDS enhanced monitoring forwarder lambda function (if versioning is enabled via publish = true) |
| <a name="output_rds_em_forwarder_lambda_source_code_hash"></a> [rds\_em\_forwarder\_lambda\_source\_code\_hash](#output\_rds\_em\_forwarder\_lambda\_source\_code\_hash) | Base64-encoded representation of raw SHA-256 sum of the RDS enhanced monitoring lambda forwarder zip file, provided either via filename or s3\_* parameters |
| <a name="output_rds_em_forwarder_role_arn"></a> [rds\_em\_forwarder\_role\_arn](#output\_rds\_em\_forwarder\_role\_arn) | The RDS enhanced monitoring forwarder lambda role arn |
| <a name="output_rds_em_forwarder_role_name"></a> [rds\_em\_forwarder\_role\_name](#output\_rds\_em\_forwarder\_role\_name) | The RDS enhanced monitoring forwarder lambda role name |
| <a name="output_rds_em_forwarder_role_policy_arn"></a> [rds\_em\_forwarder\_role\_policy\_arn](#output\_rds\_em\_forwarder\_role\_policy\_arn) | The ARN of the RDS enhanced monitoring forwarder lambda role policy |
| <a name="output_rds_em_forwarder_role_policy_name"></a> [rds\_em\_forwarder\_role\_policy\_name](#output\_rds\_em\_forwarder\_role\_policy\_name) | The name of the RDS enhanced monitoring forwarder lambda role policy |
| <a name="output_vpc_fl_forwarder_cloudwatch_log_group_arn"></a> [vpc\_fl\_forwarder\_cloudwatch\_log\_group\_arn](#output\_vpc\_fl\_forwarder\_cloudwatch\_log\_group\_arn) | The ARN of the VPC flow log forwarder lambda function CloudWatch log group |
| <a name="output_vpc_fl_forwarder_lambda_arn"></a> [vpc\_fl\_forwarder\_lambda\_arn](#output\_vpc\_fl\_forwarder\_lambda\_arn) | The ARN of the VPC flow log forwarder lambda function |
| <a name="output_vpc_fl_forwarder_lambda_qualified_arn"></a> [vpc\_fl\_forwarder\_lambda\_qualified\_arn](#output\_vpc\_fl\_forwarder\_lambda\_qualified\_arn) | The ARN of the VPC flow log forwarder lambda function (if versioning is enabled via publish = true) |
| <a name="output_vpc_fl_forwarder_lambda_source_code_hash"></a> [vpc\_fl\_forwarder\_lambda\_source\_code\_hash](#output\_vpc\_fl\_forwarder\_lambda\_source\_code\_hash) | Base64-encoded representation of raw SHA-256 sum of the VPC flow log forwarder lambda zip file, provided either via filename or s3\_* parameters |
| <a name="output_vpc_fl_forwarder_role_arn"></a> [vpc\_fl\_forwarder\_role\_arn](#output\_vpc\_fl\_forwarder\_role\_arn) | The VPC flow log forwarder lambda role arn |
| <a name="output_vpc_fl_forwarder_role_name"></a> [vpc\_fl\_forwarder\_role\_name](#output\_vpc\_fl\_forwarder\_role\_name) | The VPC flow log forwarder lambda role name |
| <a name="output_vpc_fl_forwarder_role_policy_arn"></a> [vpc\_fl\_forwarder\_role\_policy\_arn](#output\_vpc\_fl\_forwarder\_role\_policy\_arn) | The ARN of the VPC flow log forwarder lambda role policy |
| <a name="output_vpc_fl_forwarder_role_policy_name"></a> [vpc\_fl\_forwarder\_role\_policy\_name](#output\_vpc\_fl\_forwarder\_role\_policy\_name) | The name of the VPC flow log forwarder lambda role policy |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Apache-2.0 Licensed. See [LICENSE](../../LICENSE).
