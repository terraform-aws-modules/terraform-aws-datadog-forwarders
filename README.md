# AWS Datadog Forwarders Terraform module

Terraform module which creates resources to forward logs and metrics to Datadog on AWS.

The following resources are supported:

- [Log Forwarder](https://docs.datadoghq.com/serverless/forwarder/)
- [RDS Enhanced Monitoring Forwarder](https://aws.amazon.com/blogs/aws/using-enhanced-rds-monitoring-with-datadog/)
- [VPC Flow Log Forwarder](https://docs.datadoghq.com/integrations/amazon_vpc/)
- [Agent PrivateLink VPC Endpoint](https://docs.datadoghq.com/agent/guide/private-link/?tab=logs#create-your-vpc-endpoint)
- [API PrivateLink VPC Endpoint](https://docs.datadoghq.com/agent/guide/private-link/?tab=logs#create-your-vpc-endpoint)
- [Log Forwarder PrivateLink VPC Endpoint](https://docs.datadoghq.com/agent/guide/private-link/?tab=logs#create-your-vpc-endpoint)
- [Metrics PrivateLink VPC Endpoint](https://docs.datadoghq.com/agent/guide/private-link/?tab=logs#create-your-vpc-endpoint)
- [Process PrivateLink VPC Endpoint](https://docs.datadoghq.com/agent/guide/private-link/?tab=logs#create-your-vpc-endpoint)
- [Traces PrivateLink VPC Endpoint](https://docs.datadoghq.com/agent/guide/private-link/?tab=logs#create-your-vpc-endpoint)

Please refer to the official Datadog [`datadog-serverless-functions`](https://github.com/DataDog/datadog-serverless-functions/tree/master/aws) for further information on the forwarder lambda functions, configuraion via environment variables, and integration with PrivateLink endpoints.

## Security

There are several factors to keep in mind when working with and/or using this module that largely revolve around the decisions made based on security implications.

1. Based on the functionality provided by the Datadog team at [`datadog-serverless-functions`](https://github.com/DataDog/datadog-serverless-functions/tree/master/aws), the recommended approach for providing your Datadog API key is through AWS Secrets Manager. The creation of this secret is not facilitated by this module and should be created manually (or through some other means where the secret is not passed as plain text into Terraform as input).
    - Note: even though this is the recommended approach, the pattern used in the past of providing the `DD_API_KEY` as an environment variable is still supported by the module. Users are able to provde any and all environment variables to the forwarders through inputs (i.e. - `log_forwarder_environment_variables`) to configure the forwarders as desired. See [`settings.py`](https://github.com/DataDog/datadog-serverless-functions/blob/master/aws/logs_monitoring/settings.py) for more details on what environment variables are supported to configure the forwarders.
2. The use of a KMS key to encrypt/decrypt API and APP keys is required by the [`rds_enhanced_monitoring_forwarder`](./modules/rds_enhanced_monitoring_forwarder) and [`vpc_flow_log_forwarder`](./modules/vpc_flow_log_forwarder) modules/functions per the uptream source at [`datadog-serverless-functions`](https://github.com/DataDog/datadog-serverless-functions/tree/master/aws). The creation of a KMS key has been left out of this module so that users are able to better manage their KMS CMK key (and therefore the policies and usage of said key) as they see fit without over-complicating this module.
3. The roles and their permissions created by this module have several built in conditional checks in order to provide permission sets that allow the desired functionality while following the recommended approach of least privelege access. Nearly all attributes for the IAM roles and their permissions are accessible via inputs - even allowing users to provide their own IAM roles and/or policies to meet their organizational requirements.

## Vendored Artifacts

Due to Terraform not dealing with dynamically created files, especially in ephemeral environments like CI/CD pipelines, the decision was made to vendor the Lambda function artifacts within the VPC Flow Log and RDS Enhanced Monitoring modules to avoid issues. When the upstream artifacts are hosted as zipped archives available on GitHub, similar to the Log Forwarder, then this vendoring hack will be removed in favor of pulling directly from the project. Ref [Issue #374](https://github.com/DataDog/datadog-serverless-functions/issues/374)

## Usage

See [`examples`](./examples) directory for working examples to reference:

```hcl
# Note: you will need to create this secret manually prior to running
# This avoids having to pass the key to Terraform in plaintext
data "aws_secretsmanager_secret" "datadog_api_key" {
  name = "datadog/api_key"
}

module "datadog_forwarders" {
  source  = "clowdhaus/datadog-forwarders/aws"

  kms_alias             = "alias/datadog" # KMS key will need to be created outside of module
  dd_api_key_secret_arn = data.aws_secretsmanager_secret.datadog_api_key.arn

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Examples

Examples codified under the [`examples`](./examples) are intended to give users references for how to use the module(s) as well as testing/validating changes to the source code of the module(s). If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow maintainers to test your changes and to keep the examples up to date for users. Thank you!

- [Complete](./examples/complete)
- [Simple](./examples/simple)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_log_forwarder"></a> [log\_forwarder](#module\_log\_forwarder) | ./modules/log_forwarder | n/a |
| <a name="module_rds_enhanced_monitoring_forwarder"></a> [rds\_enhanced\_monitoring\_forwarder](#module\_rds\_enhanced\_monitoring\_forwarder) | ./modules/rds_enhanced_monitoring_forwarder | n/a |
| <a name="module_vpc_flow_log_forwarder"></a> [vpc\_flow\_log\_forwarder](#module\_vpc\_flow\_log\_forwarder) | ./modules/vpc_flow_log_forwarder | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_vpc_endpoint.agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.log_forwarder](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.metrics](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.processes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.traces](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_agent_vpce_policy"></a> [agent\_vpce\_policy](#input\_agent\_vpce\_policy) | Policy to attach to the agent endpoint that controls access to the service. Defaults to full access | `any` | `null` | no |
| <a name="input_agent_vpce_security_group_ids"></a> [agent\_vpce\_security\_group\_ids](#input\_agent\_vpce\_security\_group\_ids) | IDs of security groups to attach to agent endpoint | `list(string)` | `[]` | no |
| <a name="input_agent_vpce_subnet_ids"></a> [agent\_vpce\_subnet\_ids](#input\_agent\_vpce\_subnet\_ids) | IDs of subnets to associate with agent endpoint | `list(string)` | `[]` | no |
| <a name="input_agent_vpce_tags"></a> [agent\_vpce\_tags](#input\_agent\_vpce\_tags) | A map of tags to apply to the Datadog agent endpoint | `map(string)` | `{}` | no |
| <a name="input_api_vpce_policy"></a> [api\_vpce\_policy](#input\_api\_vpce\_policy) | Policy to attach to the API endpoint that controls access to the service. Defaults to full access | `any` | `null` | no |
| <a name="input_api_vpce_security_group_ids"></a> [api\_vpce\_security\_group\_ids](#input\_api\_vpce\_security\_group\_ids) | IDs of security groups to attach to API endpoint | `list(string)` | `[]` | no |
| <a name="input_api_vpce_subnet_ids"></a> [api\_vpce\_subnet\_ids](#input\_api\_vpce\_subnet\_ids) | IDs of subnets to associate with API endpoint | `list(string)` | `[]` | no |
| <a name="input_api_vpce_tags"></a> [api\_vpce\_tags](#input\_api\_vpce\_tags) | A map of tags to apply to the API endpoint | `map(string)` | `{}` | no |
| <a name="input_bucket_attach_deny_insecure_transport_policy"></a> [bucket\_attach\_deny\_insecure\_transport\_policy](#input\_bucket\_attach\_deny\_insecure\_transport\_policy) | Controls if S3 bucket should have deny non-SSL transport policy attacheds | `bool` | `true` | no |
| <a name="input_bucket_encryption_settings"></a> [bucket\_encryption\_settings](#input\_bucket\_encryption\_settings) | S3 bucket server side encryption settings | `map(string)` | <pre>{<br>  "sse_algorithm": "AES256"<br>}</pre> | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Lambda artifact S3 bucket name | `string` | `""` | no |
| <a name="input_create_agent_vpce"></a> [create\_agent\_vpce](#input\_create\_agent\_vpce) | Controls whether an agent endpoint should be created | `bool` | `false` | no |
| <a name="input_create_api_vpce"></a> [create\_api\_vpce](#input\_create\_api\_vpce) | Controls whether a API endpoint should be created | `bool` | `false` | no |
| <a name="input_create_bucket"></a> [create\_bucket](#input\_create\_bucket) | Controls whether an S3 artifact bucket should be created. this is used for the zip archive as well as caching tags | `bool` | `true` | no |
| <a name="input_create_log_forwarder"></a> [create\_log\_forwarder](#input\_create\_log\_forwarder) | Controls whether log forwarder resources should be created | `bool` | `true` | no |
| <a name="input_create_log_forwarder_role"></a> [create\_log\_forwarder\_role](#input\_create\_log\_forwarder\_role) | Controls whether an IAM role is created for the log forwarder | `bool` | `true` | no |
| <a name="input_create_log_forwarder_role_policy"></a> [create\_log\_forwarder\_role\_policy](#input\_create\_log\_forwarder\_role\_policy) | Controls whether an IAM role policy is created for the log forwarder | `bool` | `true` | no |
| <a name="input_create_log_forwarder_vpce"></a> [create\_log\_forwarder\_vpce](#input\_create\_log\_forwarder\_vpce) | Controls whether a log forwarder endpoint should be created | `bool` | `false` | no |
| <a name="input_create_metrics_vpce"></a> [create\_metrics\_vpce](#input\_create\_metrics\_vpce) | Controls whether a metrics VPC endpoint should be created | `bool` | `false` | no |
| <a name="input_create_processes_vpce"></a> [create\_processes\_vpce](#input\_create\_processes\_vpce) | Controls whether a processes endpoint should be created | `bool` | `false` | no |
| <a name="input_create_rds_em_forwarder"></a> [create\_rds\_em\_forwarder](#input\_create\_rds\_em\_forwarder) | Controls whether RDS enhanced monitoring forwarder resources should be created | `bool` | `true` | no |
| <a name="input_create_rds_em_forwarder_role"></a> [create\_rds\_em\_forwarder\_role](#input\_create\_rds\_em\_forwarder\_role) | Controls whether an IAM role is created for the RDS enhanced monitoring forwarder | `bool` | `true` | no |
| <a name="input_create_rds_em_forwarder_role_policy"></a> [create\_rds\_em\_forwarder\_role\_policy](#input\_create\_rds\_em\_forwarder\_role\_policy) | Controls whether an IAM role policy is created for the RDS enhanced monitoring forwarder | `bool` | `true` | no |
| <a name="input_create_traces_vpce"></a> [create\_traces\_vpce](#input\_create\_traces\_vpce) | Controls whether a traces endpoint should be created | `bool` | `false` | no |
| <a name="input_create_vpc_fl_forwarder"></a> [create\_vpc\_fl\_forwarder](#input\_create\_vpc\_fl\_forwarder) | Controls whether VPC flow log forwarder resources should be created | `bool` | `true` | no |
| <a name="input_create_vpc_fl_forwarder_role"></a> [create\_vpc\_fl\_forwarder\_role](#input\_create\_vpc\_fl\_forwarder\_role) | Controls whether an IAM role is created for the VPC flow log forwarder | `bool` | `true` | no |
| <a name="input_create_vpc_fl_forwarder_role_policy"></a> [create\_vpc\_fl\_forwarder\_role\_policy](#input\_create\_vpc\_fl\_forwarder\_role\_policy) | Controls whether an IAM role policy is created for the VPC flow log forwarder | `bool` | `true` | no |
| <a name="input_dd_api_key"></a> [dd\_api\_key](#input\_dd\_api\_key) | The Datadog API key, which can be found from the APIs page (/account/settings#api). It will be stored in AWS Secrets Manager securely. If DdApiKeySecretArn is also set, this value will not be used. This value must still be set, however | `string` | `""` | no |
| <a name="input_dd_api_key_secret_arn"></a> [dd\_api\_key\_secret\_arn](#input\_dd\_api\_key\_secret\_arn) | The ARN of the Secrets Manager secret storing the Datadog API key, if you already have it stored in Secrets Manager. You still need to set a dummy value for `dd_api_key` to satisfy the requirement, though that value won't be used | `string` | `""` | no |
| <a name="input_dd_app_key"></a> [dd\_app\_key](#input\_dd\_app\_key) | The Datadog application key associated with the user account that created it, which can be found from the APIs page | `string` | `""` | no |
| <a name="input_dd_site"></a> [dd\_site](#input\_dd\_site) | Define your Datadog Site to send data to. For the Datadog EU site, set to datadoghq.eu | `string` | `"datadoghq.com"` | no |
| <a name="input_kms_alias"></a> [kms\_alias](#input\_kms\_alias) | Alias of KMS key used to encrypt the Datadog API keys - must start with `alias/` | `string` | n/a | yes |
| <a name="input_log_forwarder_architectures"></a> [log\_forwarder\_architectures](#input\_log\_forwarder\_architectures) | Instruction set architecture for your Lambda function. Valid values are `["x86_64"]` and `["arm64"]`. Default is `["x86_64"]` | `list(string)` | <pre>[<br>  "x86_64"<br>]</pre> | no |
| <a name="input_log_forwarder_bucket_prefix"></a> [log\_forwarder\_bucket\_prefix](#input\_log\_forwarder\_bucket\_prefix) | S3 object key prefix to prepend to zip archive name | `string` | `""` | no |
| <a name="input_log_forwarder_environment_variables"></a> [log\_forwarder\_environment\_variables](#input\_log\_forwarder\_environment\_variables) | A map of environment variables for the log forwarder lambda function | `map(string)` | `{}` | no |
| <a name="input_log_forwarder_kms_key_arn"></a> [log\_forwarder\_kms\_key\_arn](#input\_log\_forwarder\_kms\_key\_arn) | KMS key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key | `string` | `null` | no |
| <a name="input_log_forwarder_lambda_tags"></a> [log\_forwarder\_lambda\_tags](#input\_log\_forwarder\_lambda\_tags) | A map of tags to apply to the log forwarder lambda function | `map(string)` | `{}` | no |
| <a name="input_log_forwarder_layers"></a> [log\_forwarder\_layers](#input\_log\_forwarder\_layers) | List of Lambda Layer Version ARNs (maximum of 5) to attach to the log forwarder lambda | `list(string)` | `[]` | no |
| <a name="input_log_forwarder_log_retention_days"></a> [log\_forwarder\_log\_retention\_days](#input\_log\_forwarder\_log\_retention\_days) | Log forwarder CloudWatch log group retention in days | `number` | `7` | no |
| <a name="input_log_forwarder_memory_size"></a> [log\_forwarder\_memory\_size](#input\_log\_forwarder\_memory\_size) | Memory size for the log forwarder lambda function | `number` | `1024` | no |
| <a name="input_log_forwarder_name"></a> [log\_forwarder\_name](#input\_log\_forwarder\_name) | Log forwarder lambda name | `string` | `"datadog-log-forwarder"` | no |
| <a name="input_log_forwarder_policy_arn"></a> [log\_forwarder\_policy\_arn](#input\_log\_forwarder\_policy\_arn) | IAM policy arn for log forwarder lambda function to utilize | `string` | `null` | no |
| <a name="input_log_forwarder_policy_name"></a> [log\_forwarder\_policy\_name](#input\_log\_forwarder\_policy\_name) | Log forwarder policy name | `string` | `""` | no |
| <a name="input_log_forwarder_policy_path"></a> [log\_forwarder\_policy\_path](#input\_log\_forwarder\_policy\_path) | Log forwarder policy path | `string` | `null` | no |
| <a name="input_log_forwarder_publish"></a> [log\_forwarder\_publish](#input\_log\_forwarder\_publish) | Whether to publish creation/change as a new Lambda Function Version | `bool` | `false` | no |
| <a name="input_log_forwarder_reserved_concurrent_executions"></a> [log\_forwarder\_reserved\_concurrent\_executions](#input\_log\_forwarder\_reserved\_concurrent\_executions) | The amount of reserved concurrent executions for the log forwarder lambda function | `number` | `100` | no |
| <a name="input_log_forwarder_role_arn"></a> [log\_forwarder\_role\_arn](#input\_log\_forwarder\_role\_arn) | IAM role arn for log forwarder lambda function to utilize | `string` | `null` | no |
| <a name="input_log_forwarder_role_max_session_duration"></a> [log\_forwarder\_role\_max\_session\_duration](#input\_log\_forwarder\_role\_max\_session\_duration) | The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours | `number` | `null` | no |
| <a name="input_log_forwarder_role_name"></a> [log\_forwarder\_role\_name](#input\_log\_forwarder\_role\_name) | Log forwarder role name | `string` | `""` | no |
| <a name="input_log_forwarder_role_path"></a> [log\_forwarder\_role\_path](#input\_log\_forwarder\_role\_path) | Log forwarder role path | `string` | `null` | no |
| <a name="input_log_forwarder_role_permissions_boundary"></a> [log\_forwarder\_role\_permissions\_boundary](#input\_log\_forwarder\_role\_permissions\_boundary) | The ARN of the policy that is used to set the permissions boundary for the log forwarder role | `string` | `null` | no |
| <a name="input_log_forwarder_role_tags"></a> [log\_forwarder\_role\_tags](#input\_log\_forwarder\_role\_tags) | A map of tags to apply to the log forwarder role | `map(string)` | `{}` | no |
| <a name="input_log_forwarder_runtime"></a> [log\_forwarder\_runtime](#input\_log\_forwarder\_runtime) | Lambda function runtime | `string` | `"python3.9"` | no |
| <a name="input_log_forwarder_s3_log_bucket_arns"></a> [log\_forwarder\_s3\_log\_bucket\_arns](#input\_log\_forwarder\_s3\_log\_bucket\_arns) | S3 log buckets for forwarder to read and forward logs to Datadog | `list(string)` | `[]` | no |
| <a name="input_log_forwarder_s3_zip_kms_key_id"></a> [log\_forwarder\_s3\_zip\_kms\_key\_id](#input\_log\_forwarder\_s3\_zip\_kms\_key\_id) | The AWS KMS Key ARN to use for object encryption | `string` | `null` | no |
| <a name="input_log_forwarder_s3_zip_metadata"></a> [log\_forwarder\_s3\_zip\_metadata](#input\_log\_forwarder\_s3\_zip\_metadata) | A map of keys/values to provision metadata (will be automatically prefixed by `x-amz-meta-` | `map(string)` | `{}` | no |
| <a name="input_log_forwarder_s3_zip_server_side_encryption"></a> [log\_forwarder\_s3\_zip\_server\_side\_encryption](#input\_log\_forwarder\_s3\_zip\_server\_side\_encryption) | Server-side encryption of the zip object in S3. Valid values are `AES256` and `aws:kms` | `string` | `null` | no |
| <a name="input_log_forwarder_s3_zip_storage_class"></a> [log\_forwarder\_s3\_zip\_storage\_class](#input\_log\_forwarder\_s3\_zip\_storage\_class) | Specifies the desired Storage Class for the zip object. Can be either `STANDARD`, `REDUCED_REDUNDANCY`, `ONEZONE_IA`, `INTELLIGENT_TIERING`, or `STANDARD_IA` | `string` | `null` | no |
| <a name="input_log_forwarder_s3_zip_tags"></a> [log\_forwarder\_s3\_zip\_tags](#input\_log\_forwarder\_s3\_zip\_tags) | A map of tags to apply to the zip archive in S3 | `map(string)` | `{}` | no |
| <a name="input_log_forwarder_security_group_ids"></a> [log\_forwarder\_security\_group\_ids](#input\_log\_forwarder\_security\_group\_ids) | List of security group ids when forwarder lambda function should run in the VPC | `list(string)` | `null` | no |
| <a name="input_log_forwarder_subnet_ids"></a> [log\_forwarder\_subnet\_ids](#input\_log\_forwarder\_subnet\_ids) | List of subnet ids when forwarder lambda function should run in the VPC. Usually private or intra subnets | `list(string)` | `null` | no |
| <a name="input_log_forwarder_tags"></a> [log\_forwarder\_tags](#input\_log\_forwarder\_tags) | A map of tags to apply to the log forwarder resources | `map(string)` | `{}` | no |
| <a name="input_log_forwarder_timeout"></a> [log\_forwarder\_timeout](#input\_log\_forwarder\_timeout) | The amount of time the log forwarder lambda has to execute in seconds | `number` | `120` | no |
| <a name="input_log_forwarder_use_policy_name_prefix"></a> [log\_forwarder\_use\_policy\_name\_prefix](#input\_log\_forwarder\_use\_policy\_name\_prefix) | Whether to use unique name beginning with the specified `policy_name` for the log forwarder policy | `bool` | `false` | no |
| <a name="input_log_forwarder_use_role_name_prefix"></a> [log\_forwarder\_use\_role\_name\_prefix](#input\_log\_forwarder\_use\_role\_name\_prefix) | Whether to use unique name beginning with the specified `role_name` for the log forwarder role | `bool` | `false` | no |
| <a name="input_log_forwarder_version"></a> [log\_forwarder\_version](#input\_log\_forwarder\_version) | Forwarder version - see https://github.com/DataDog/datadog-serverless-functions/releases | `string` | `"3.44.0"` | no |
| <a name="input_log_forwarder_vpce_policy"></a> [log\_forwarder\_vpce\_policy](#input\_log\_forwarder\_vpce\_policy) | Policy to attach to the log forwarder endpoint that controls access to the service. Defaults to full access | `any` | `null` | no |
| <a name="input_log_forwarder_vpce_security_group_ids"></a> [log\_forwarder\_vpce\_security\_group\_ids](#input\_log\_forwarder\_vpce\_security\_group\_ids) | IDs of security groups to attach to log forwarder endpoint | `list(string)` | `[]` | no |
| <a name="input_log_forwarder_vpce_subnet_ids"></a> [log\_forwarder\_vpce\_subnet\_ids](#input\_log\_forwarder\_vpce\_subnet\_ids) | IDs of subnets to associate with log forwarder endpoint | `list(string)` | `[]` | no |
| <a name="input_log_forwarder_vpce_tags"></a> [log\_forwarder\_vpce\_tags](#input\_log\_forwarder\_vpce\_tags) | A map of tags to apply to the log forwarder endpoint | `map(string)` | `{}` | no |
| <a name="input_metrics_vpce_policy"></a> [metrics\_vpce\_policy](#input\_metrics\_vpce\_policy) | Policy to attach to the metrics endpoint that controls access to the service. Defaults to full access | `any` | `null` | no |
| <a name="input_metrics_vpce_security_group_ids"></a> [metrics\_vpce\_security\_group\_ids](#input\_metrics\_vpce\_security\_group\_ids) | IDs of security groups to attach to metrics endpoint | `list(string)` | `[]` | no |
| <a name="input_metrics_vpce_subnet_ids"></a> [metrics\_vpce\_subnet\_ids](#input\_metrics\_vpce\_subnet\_ids) | IDs of subnets to associate with metrics endpoint | `list(string)` | `[]` | no |
| <a name="input_metrics_vpce_tags"></a> [metrics\_vpce\_tags](#input\_metrics\_vpce\_tags) | A map of tags to apply to the metrics endpoint | `map(string)` | `{}` | no |
| <a name="input_processes_vpce_policy"></a> [processes\_vpce\_policy](#input\_processes\_vpce\_policy) | Policy to attach to the processes endpoint that controls access to the service. Defaults to full access | `any` | `null` | no |
| <a name="input_processes_vpce_security_group_ids"></a> [processes\_vpce\_security\_group\_ids](#input\_processes\_vpce\_security\_group\_ids) | IDs of security groups to attach to processes endpoint | `list(string)` | `[]` | no |
| <a name="input_processes_vpce_subnet_ids"></a> [processes\_vpce\_subnet\_ids](#input\_processes\_vpce\_subnet\_ids) | IDs of subnets to associate with processes endpoint | `list(string)` | `[]` | no |
| <a name="input_processes_vpce_tags"></a> [processes\_vpce\_tags](#input\_processes\_vpce\_tags) | A map of tags to apply to the processes endpoint | `map(string)` | `{}` | no |
| <a name="input_rds_em_forwarder_architectures"></a> [rds\_em\_forwarder\_architectures](#input\_rds\_em\_forwarder\_architectures) | Instruction set architecture for your Lambda function. Valid values are `["x86_64"]` and `["arm64"]`. Default is `["x86_64"]` | `list(string)` | <pre>[<br>  "x86_64"<br>]</pre> | no |
| <a name="input_rds_em_forwarder_environment_variables"></a> [rds\_em\_forwarder\_environment\_variables](#input\_rds\_em\_forwarder\_environment\_variables) | A map of environment variables for the RDS enhanced monitoring forwarder lambda function | `map(string)` | `{}` | no |
| <a name="input_rds_em_forwarder_kms_key_arn"></a> [rds\_em\_forwarder\_kms\_key\_arn](#input\_rds\_em\_forwarder\_kms\_key\_arn) | KMS key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key | `string` | `null` | no |
| <a name="input_rds_em_forwarder_lambda_tags"></a> [rds\_em\_forwarder\_lambda\_tags](#input\_rds\_em\_forwarder\_lambda\_tags) | A map of tags to apply to the RDS enhanced monitoring forwarder lambda function | `map(string)` | `{}` | no |
| <a name="input_rds_em_forwarder_layers"></a> [rds\_em\_forwarder\_layers](#input\_rds\_em\_forwarder\_layers) | List of Lambda Layer Version ARNs (maximum of 5) to attach to the RDS enhanced monitoring forwarder lambda | `list(string)` | `[]` | no |
| <a name="input_rds_em_forwarder_log_retention_days"></a> [rds\_em\_forwarder\_log\_retention\_days](#input\_rds\_em\_forwarder\_log\_retention\_days) | RDS enhanced monitoring forwarder CloudWatch log group retention in days | `number` | `7` | no |
| <a name="input_rds_em_forwarder_memory_size"></a> [rds\_em\_forwarder\_memory\_size](#input\_rds\_em\_forwarder\_memory\_size) | Memory size for the RDS enhanced monitoring forwarder lambda function | `number` | `256` | no |
| <a name="input_rds_em_forwarder_name"></a> [rds\_em\_forwarder\_name](#input\_rds\_em\_forwarder\_name) | RDS enhanced monitoring forwarder lambda name | `string` | `"datadog-rds-enhanced-monitoring-forwarder"` | no |
| <a name="input_rds_em_forwarder_policy_arn"></a> [rds\_em\_forwarder\_policy\_arn](#input\_rds\_em\_forwarder\_policy\_arn) | IAM policy arn for RDS enhanced monitoring forwarder lambda function to utilize | `string` | `null` | no |
| <a name="input_rds_em_forwarder_policy_name"></a> [rds\_em\_forwarder\_policy\_name](#input\_rds\_em\_forwarder\_policy\_name) | RDS enhanced monitoring forwarder policy name | `string` | `""` | no |
| <a name="input_rds_em_forwarder_policy_path"></a> [rds\_em\_forwarder\_policy\_path](#input\_rds\_em\_forwarder\_policy\_path) | RDS enhanced monitoring forwarder policy path | `string` | `null` | no |
| <a name="input_rds_em_forwarder_publish"></a> [rds\_em\_forwarder\_publish](#input\_rds\_em\_forwarder\_publish) | Whether to publish creation/change as a new fambda function Version | `bool` | `false` | no |
| <a name="input_rds_em_forwarder_reserved_concurrent_executions"></a> [rds\_em\_forwarder\_reserved\_concurrent\_executions](#input\_rds\_em\_forwarder\_reserved\_concurrent\_executions) | The amount of reserved concurrent executions for the RDS enhanced monitoring forwarder lambda function | `number` | `10` | no |
| <a name="input_rds_em_forwarder_role_arn"></a> [rds\_em\_forwarder\_role\_arn](#input\_rds\_em\_forwarder\_role\_arn) | IAM role arn for RDS enhanced monitoring forwarder lambda function to utilize | `string` | `null` | no |
| <a name="input_rds_em_forwarder_role_max_session_duration"></a> [rds\_em\_forwarder\_role\_max\_session\_duration](#input\_rds\_em\_forwarder\_role\_max\_session\_duration) | The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours | `number` | `null` | no |
| <a name="input_rds_em_forwarder_role_name"></a> [rds\_em\_forwarder\_role\_name](#input\_rds\_em\_forwarder\_role\_name) | RDS enhanced monitoring forwarder role name | `string` | `""` | no |
| <a name="input_rds_em_forwarder_role_path"></a> [rds\_em\_forwarder\_role\_path](#input\_rds\_em\_forwarder\_role\_path) | RDS enhanced monitoring forwarder role path | `string` | `null` | no |
| <a name="input_rds_em_forwarder_role_permissions_boundary"></a> [rds\_em\_forwarder\_role\_permissions\_boundary](#input\_rds\_em\_forwarder\_role\_permissions\_boundary) | The ARN of the policy that is used to set the permissions boundary for the RDS enhanced monitoring forwarder role | `string` | `null` | no |
| <a name="input_rds_em_forwarder_role_tags"></a> [rds\_em\_forwarder\_role\_tags](#input\_rds\_em\_forwarder\_role\_tags) | A map of tags to apply to the RDS enhanced monitoring forwarder role | `map(string)` | `{}` | no |
| <a name="input_rds_em_forwarder_runtime"></a> [rds\_em\_forwarder\_runtime](#input\_rds\_em\_forwarder\_runtime) | Lambda function runtime | `string` | `"python3.9"` | no |
| <a name="input_rds_em_forwarder_security_group_ids"></a> [rds\_em\_forwarder\_security\_group\_ids](#input\_rds\_em\_forwarder\_security\_group\_ids) | List of security group ids when forwarder lambda function should run in the VPC | `list(string)` | `null` | no |
| <a name="input_rds_em_forwarder_subnet_ids"></a> [rds\_em\_forwarder\_subnet\_ids](#input\_rds\_em\_forwarder\_subnet\_ids) | List of subnet ids when forwarder lambda function should run in the VPC. Usually private or intra subnets | `list(string)` | `null` | no |
| <a name="input_rds_em_forwarder_tags"></a> [rds\_em\_forwarder\_tags](#input\_rds\_em\_forwarder\_tags) | A map of tags to apply to the RDS enhanced monitoring forwarder resources | `map(string)` | `{}` | no |
| <a name="input_rds_em_forwarder_timeout"></a> [rds\_em\_forwarder\_timeout](#input\_rds\_em\_forwarder\_timeout) | The amount of time the RDS enhanced monitoring forwarder lambda has to execute in seconds | `number` | `10` | no |
| <a name="input_rds_em_forwarder_use_policy_name_prefix"></a> [rds\_em\_forwarder\_use\_policy\_name\_prefix](#input\_rds\_em\_forwarder\_use\_policy\_name\_prefix) | Whether to use unique name beginning with the specified `rds_em_forwarder_policy_name` for the RDS enhanced monitoring forwarder role | `bool` | `false` | no |
| <a name="input_rds_em_forwarder_use_role_name_prefix"></a> [rds\_em\_forwarder\_use\_role\_name\_prefix](#input\_rds\_em\_forwarder\_use\_role\_name\_prefix) | Whether to use unique name beginning with the specified `rds_em_forwarder_role_name` for the RDS enhanced monitoring forwarder role | `bool` | `false` | no |
| <a name="input_rds_em_forwarder_version"></a> [rds\_em\_forwarder\_version](#input\_rds\_em\_forwarder\_version) | RDS enhanced monitoring lambda version - see https://github.com/DataDog/datadog-serverless-functions/releases | `string` | `"3.44.0"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to use on all resources | `map(string)` | `{}` | no |
| <a name="input_traces_vpce_policy"></a> [traces\_vpce\_policy](#input\_traces\_vpce\_policy) | Policy to attach to the traces endpoint that controls access to the service. Defaults to full access | `any` | `null` | no |
| <a name="input_traces_vpce_security_group_ids"></a> [traces\_vpce\_security\_group\_ids](#input\_traces\_vpce\_security\_group\_ids) | IDs of security groups to attach to traces endpoint | `list(string)` | `[]` | no |
| <a name="input_traces_vpce_subnet_ids"></a> [traces\_vpce\_subnet\_ids](#input\_traces\_vpce\_subnet\_ids) | IDs of subnets to associate with traces endpoint | `list(string)` | `[]` | no |
| <a name="input_traces_vpce_tags"></a> [traces\_vpce\_tags](#input\_traces\_vpce\_tags) | A map of tags to apply to the traces endpoint | `map(string)` | `{}` | no |
| <a name="input_vpc_fl_forwarder_architectures"></a> [vpc\_fl\_forwarder\_architectures](#input\_vpc\_fl\_forwarder\_architectures) | Instruction set architecture for your Lambda function. Valid values are `["x86_64"]` and `["arm64"]`. Default is `["x86_64"]` | `list(string)` | <pre>[<br>  "x86_64"<br>]</pre> | no |
| <a name="input_vpc_fl_forwarder_environment_variables"></a> [vpc\_fl\_forwarder\_environment\_variables](#input\_vpc\_fl\_forwarder\_environment\_variables) | A map of environment variables for the VPC flow log forwarder lambda function | `map(string)` | `{}` | no |
| <a name="input_vpc_fl_forwarder_kms_key_arn"></a> [vpc\_fl\_forwarder\_kms\_key\_arn](#input\_vpc\_fl\_forwarder\_kms\_key\_arn) | KMS key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key | `string` | `null` | no |
| <a name="input_vpc_fl_forwarder_lambda_tags"></a> [vpc\_fl\_forwarder\_lambda\_tags](#input\_vpc\_fl\_forwarder\_lambda\_tags) | A map of tags to apply to the VPC flow log forwarder lambda function | `map(string)` | `{}` | no |
| <a name="input_vpc_fl_forwarder_layers"></a> [vpc\_fl\_forwarder\_layers](#input\_vpc\_fl\_forwarder\_layers) | List of Lambda Layer Version ARNs (maximum of 5) to attach to the VPC flow log forwarder lambda | `list(string)` | `[]` | no |
| <a name="input_vpc_fl_forwarder_log_retention_days"></a> [vpc\_fl\_forwarder\_log\_retention\_days](#input\_vpc\_fl\_forwarder\_log\_retention\_days) | VPC flow log forwarder CloudWatch log group retention in days | `number` | `7` | no |
| <a name="input_vpc_fl_forwarder_memory_size"></a> [vpc\_fl\_forwarder\_memory\_size](#input\_vpc\_fl\_forwarder\_memory\_size) | Memory size for the VPC flow log forwarder lambda function | `number` | `256` | no |
| <a name="input_vpc_fl_forwarder_name"></a> [vpc\_fl\_forwarder\_name](#input\_vpc\_fl\_forwarder\_name) | VPC flow log forwarder lambda name | `string` | `"datadog-vpc-flow-log-forwarder"` | no |
| <a name="input_vpc_fl_forwarder_policy_arn"></a> [vpc\_fl\_forwarder\_policy\_arn](#input\_vpc\_fl\_forwarder\_policy\_arn) | IAM policy arn for VPC flow log forwarder lambda function to utilize | `string` | `null` | no |
| <a name="input_vpc_fl_forwarder_policy_name"></a> [vpc\_fl\_forwarder\_policy\_name](#input\_vpc\_fl\_forwarder\_policy\_name) | VPC flow log forwarder policy name | `string` | `""` | no |
| <a name="input_vpc_fl_forwarder_policy_path"></a> [vpc\_fl\_forwarder\_policy\_path](#input\_vpc\_fl\_forwarder\_policy\_path) | VPC flow log forwarder policy path | `string` | `null` | no |
| <a name="input_vpc_fl_forwarder_publish"></a> [vpc\_fl\_forwarder\_publish](#input\_vpc\_fl\_forwarder\_publish) | Whether to publish creation/change as a new fambda function Version | `bool` | `false` | no |
| <a name="input_vpc_fl_forwarder_read_cloudwatch_logs"></a> [vpc\_fl\_forwarder\_read\_cloudwatch\_logs](#input\_vpc\_fl\_forwarder\_read\_cloudwatch\_logs) | Whether the VPC flow log forwarder will read CloudWatch log groups for VPC flow logs | `bool` | `false` | no |
| <a name="input_vpc_fl_forwarder_reserved_concurrent_executions"></a> [vpc\_fl\_forwarder\_reserved\_concurrent\_executions](#input\_vpc\_fl\_forwarder\_reserved\_concurrent\_executions) | The amount of reserved concurrent executions for the VPC flow log forwarder lambda function | `number` | `10` | no |
| <a name="input_vpc_fl_forwarder_role_arn"></a> [vpc\_fl\_forwarder\_role\_arn](#input\_vpc\_fl\_forwarder\_role\_arn) | IAM role arn for VPC flow log forwarder lambda function to utilize | `string` | `null` | no |
| <a name="input_vpc_fl_forwarder_role_max_session_duration"></a> [vpc\_fl\_forwarder\_role\_max\_session\_duration](#input\_vpc\_fl\_forwarder\_role\_max\_session\_duration) | The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours | `number` | `null` | no |
| <a name="input_vpc_fl_forwarder_role_name"></a> [vpc\_fl\_forwarder\_role\_name](#input\_vpc\_fl\_forwarder\_role\_name) | VPC flow log forwarder role name | `string` | `""` | no |
| <a name="input_vpc_fl_forwarder_role_path"></a> [vpc\_fl\_forwarder\_role\_path](#input\_vpc\_fl\_forwarder\_role\_path) | VPC flow log forwarder role path | `string` | `null` | no |
| <a name="input_vpc_fl_forwarder_role_permissions_boundary"></a> [vpc\_fl\_forwarder\_role\_permissions\_boundary](#input\_vpc\_fl\_forwarder\_role\_permissions\_boundary) | The ARN of the policy that is used to set the permissions boundary for the VPC flow log forwarder role | `string` | `null` | no |
| <a name="input_vpc_fl_forwarder_role_tags"></a> [vpc\_fl\_forwarder\_role\_tags](#input\_vpc\_fl\_forwarder\_role\_tags) | A map of tags to apply to the VPC flow log forwarder role | `map(string)` | `{}` | no |
| <a name="input_vpc_fl_forwarder_runtime"></a> [vpc\_fl\_forwarder\_runtime](#input\_vpc\_fl\_forwarder\_runtime) | Lambda function runtime | `string` | `"python3.9"` | no |
| <a name="input_vpc_fl_forwarder_s3_log_bucket_arns"></a> [vpc\_fl\_forwarder\_s3\_log\_bucket\_arns](#input\_vpc\_fl\_forwarder\_s3\_log\_bucket\_arns) | S3 log buckets for VPC flow log forwarder to read and forward to Datadog | `list(string)` | `[]` | no |
| <a name="input_vpc_fl_forwarder_security_group_ids"></a> [vpc\_fl\_forwarder\_security\_group\_ids](#input\_vpc\_fl\_forwarder\_security\_group\_ids) | List of security group ids when forwarder lambda function should run in the VPC | `list(string)` | `null` | no |
| <a name="input_vpc_fl_forwarder_subnet_ids"></a> [vpc\_fl\_forwarder\_subnet\_ids](#input\_vpc\_fl\_forwarder\_subnet\_ids) | List of subnet ids when forwarder lambda function should run in the VPC. Usually private or intra subnets | `list(string)` | `null` | no |
| <a name="input_vpc_fl_forwarder_tags"></a> [vpc\_fl\_forwarder\_tags](#input\_vpc\_fl\_forwarder\_tags) | A map of tags to apply to the VPC flow log forwarder resources | `map(string)` | `{}` | no |
| <a name="input_vpc_fl_forwarder_timeout"></a> [vpc\_fl\_forwarder\_timeout](#input\_vpc\_fl\_forwarder\_timeout) | The amount of time the VPC flow log forwarder lambda has to execute in seconds | `number` | `10` | no |
| <a name="input_vpc_fl_forwarder_use_policy_name_prefix"></a> [vpc\_fl\_forwarder\_use\_policy\_name\_prefix](#input\_vpc\_fl\_forwarder\_use\_policy\_name\_prefix) | Whether to use unique name beginning with the specified `vpc_fl_forwarder_policy_name` for the VPC flow log forwarder role | `bool` | `false` | no |
| <a name="input_vpc_fl_forwarder_use_role_name_prefix"></a> [vpc\_fl\_forwarder\_use\_role\_name\_prefix](#input\_vpc\_fl\_forwarder\_use\_role\_name\_prefix) | Whether to use unique name beginning with the specified `vpc_fl_forwarder_role_name` for the VPC flow log forwarder role | `bool` | `false` | no |
| <a name="input_vpc_fl_forwarder_version"></a> [vpc\_fl\_forwarder\_version](#input\_vpc\_fl\_forwarder\_version) | VPC flow log lambda version - see https://github.com/DataDog/datadog-serverless-functions/releases | `string` | `"3.44.0"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of VPC to provision endpoints within | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_agent_endpoint_arn"></a> [agent\_endpoint\_arn](#output\_agent\_endpoint\_arn) | ARN of the agent VPC endpoint |
| <a name="output_agent_endpoint_dns_entry"></a> [agent\_endpoint\_dns\_entry](#output\_agent\_endpoint\_dns\_entry) | DNS entries of the agent VPC endpoint |
| <a name="output_agent_endpoint_id"></a> [agent\_endpoint\_id](#output\_agent\_endpoint\_id) | ID of the agent VPC endpoint |
| <a name="output_agent_endpoint_network_interface_ids"></a> [agent\_endpoint\_network\_interface\_ids](#output\_agent\_endpoint\_network\_interface\_ids) | One or more network interfaces for the agent VPC endpoint |
| <a name="output_agent_endpoint_owner_id"></a> [agent\_endpoint\_owner\_id](#output\_agent\_endpoint\_owner\_id) | The ID of the AWS account that owns the agent VPC endpoint |
| <a name="output_agent_endpoint_state"></a> [agent\_endpoint\_state](#output\_agent\_endpoint\_state) | The state of the agent VPC endpoint |
| <a name="output_api_endpoint_arn"></a> [api\_endpoint\_arn](#output\_api\_endpoint\_arn) | ARN of the API VPC endpoint |
| <a name="output_api_endpoint_dns_entry"></a> [api\_endpoint\_dns\_entry](#output\_api\_endpoint\_dns\_entry) | DNS entries of the API VPC endpoint |
| <a name="output_api_endpoint_id"></a> [api\_endpoint\_id](#output\_api\_endpoint\_id) | ID of the API VPC endpoint |
| <a name="output_api_endpoint_network_interface_ids"></a> [api\_endpoint\_network\_interface\_ids](#output\_api\_endpoint\_network\_interface\_ids) | One or more network interfaces for API api VPC endpoint |
| <a name="output_api_endpoint_owner_id"></a> [api\_endpoint\_owner\_id](#output\_api\_endpoint\_owner\_id) | The ID of the AWS account that owns the API VPC endpoint |
| <a name="output_api_endpoint_state"></a> [api\_endpoint\_state](#output\_api\_endpoint\_state) | The state of the API VPC endpoint |
| <a name="output_log_forwarder_cloudwatch_log_group_arn"></a> [log\_forwarder\_cloudwatch\_log\_group\_arn](#output\_log\_forwarder\_cloudwatch\_log\_group\_arn) | The ARN of the log forwarder lambda function CloudWatch log group |
| <a name="output_log_forwarder_endpoint_arn"></a> [log\_forwarder\_endpoint\_arn](#output\_log\_forwarder\_endpoint\_arn) | ARN of the log forwarder VPC endpoint |
| <a name="output_log_forwarder_endpoint_dns_entry"></a> [log\_forwarder\_endpoint\_dns\_entry](#output\_log\_forwarder\_endpoint\_dns\_entry) | DNS entries of the log forwarder VPC endpoint |
| <a name="output_log_forwarder_endpoint_id"></a> [log\_forwarder\_endpoint\_id](#output\_log\_forwarder\_endpoint\_id) | ID of the log forwarder VPC endpoint |
| <a name="output_log_forwarder_endpoint_network_interface_ids"></a> [log\_forwarder\_endpoint\_network\_interface\_ids](#output\_log\_forwarder\_endpoint\_network\_interface\_ids) | One or more network interfaces for the log forwarder VPC endpoint |
| <a name="output_log_forwarder_endpoint_owner_id"></a> [log\_forwarder\_endpoint\_owner\_id](#output\_log\_forwarder\_endpoint\_owner\_id) | The ID of the AWS account that owns the log forwarder VPC endpoint |
| <a name="output_log_forwarder_endpoint_state"></a> [log\_forwarder\_endpoint\_state](#output\_log\_forwarder\_endpoint\_state) | The state of the log forwarder VPC endpoint |
| <a name="output_log_forwarder_lambda_arn"></a> [log\_forwarder\_lambda\_arn](#output\_log\_forwarder\_lambda\_arn) | The ARN of the log forwarder lambda function |
| <a name="output_log_forwarder_lambda_kms_key_arn"></a> [log\_forwarder\_lambda\_kms\_key\_arn](#output\_log\_forwarder\_lambda\_kms\_key\_arn) | (Optional) The ARN for the KMS encryption key for the log forwarder lambda function |
| <a name="output_log_forwarder_lambda_qualified_arn"></a> [log\_forwarder\_lambda\_qualified\_arn](#output\_log\_forwarder\_lambda\_qualified\_arn) | The ARN of the log forwarder lambda function (if versioning is enabled via publish = true) |
| <a name="output_log_forwarder_lambda_source_code_hash"></a> [log\_forwarder\_lambda\_source\_code\_hash](#output\_log\_forwarder\_lambda\_source\_code\_hash) | Base64-encoded representation of raw SHA-256 sum of the log forwarder zip file, provided either via filename or s3\_* parameters |
| <a name="output_log_forwarder_lambda_version"></a> [log\_forwarder\_lambda\_version](#output\_log\_forwarder\_lambda\_version) | Latest published version of the log forwarder lambda function |
| <a name="output_log_forwarder_role_arn"></a> [log\_forwarder\_role\_arn](#output\_log\_forwarder\_role\_arn) | The log forwarder lambda role arn |
| <a name="output_log_forwarder_role_id"></a> [log\_forwarder\_role\_id](#output\_log\_forwarder\_role\_id) | The log forwarder lambda role id |
| <a name="output_log_forwarder_role_name"></a> [log\_forwarder\_role\_name](#output\_log\_forwarder\_role\_name) | The log forwarder lambda role name |
| <a name="output_log_forwarder_role_policy_arn"></a> [log\_forwarder\_role\_policy\_arn](#output\_log\_forwarder\_role\_policy\_arn) | The ARN of the log forwarder lambda role policy |
| <a name="output_log_forwarder_role_policy_id"></a> [log\_forwarder\_role\_policy\_id](#output\_log\_forwarder\_role\_policy\_id) | The ID of the log forwarder lambda role policy |
| <a name="output_log_forwarder_role_policy_name"></a> [log\_forwarder\_role\_policy\_name](#output\_log\_forwarder\_role\_policy\_name) | The name of the log forwarder lambda role policy |
| <a name="output_log_forwarder_role_unique_id"></a> [log\_forwarder\_role\_unique\_id](#output\_log\_forwarder\_role\_unique\_id) | The stable and unique string identifying the log forwarder lambda role |
| <a name="output_log_forwarder_s3_bucket_arn"></a> [log\_forwarder\_s3\_bucket\_arn](#output\_log\_forwarder\_s3\_bucket\_arn) | The ARN of the log forwarder bucket. Will be of format arn:aws:s3:::bucketname |
| <a name="output_log_forwarder_s3_bucket_domain_name"></a> [log\_forwarder\_s3\_bucket\_domain\_name](#output\_log\_forwarder\_s3\_bucket\_domain\_name) | The log forwarder bucket domain name. Will be of format bucketname.s3.amazonaws.com |
| <a name="output_log_forwarder_s3_bucket_id"></a> [log\_forwarder\_s3\_bucket\_id](#output\_log\_forwarder\_s3\_bucket\_id) | The name of the log forwarder bucket |
| <a name="output_log_forwarder_s3_bucket_regional_domain_name"></a> [log\_forwarder\_s3\_bucket\_regional\_domain\_name](#output\_log\_forwarder\_s3\_bucket\_regional\_domain\_name) | The log forwarder bucket region-specific domain name. The bucket domain name including the region name |
| <a name="output_log_forwarder_s3_object_etag"></a> [log\_forwarder\_s3\_object\_etag](#output\_log\_forwarder\_s3\_object\_etag) | The ETag generated for the log forwarder lambda zip object (an MD5 sum of the object content) |
| <a name="output_log_forwarder_s3_object_id"></a> [log\_forwarder\_s3\_object\_id](#output\_log\_forwarder\_s3\_object\_id) | The `key` of the log forwarder lambda zip archive |
| <a name="output_log_forwarder_s3_object_version"></a> [log\_forwarder\_s3\_object\_version](#output\_log\_forwarder\_s3\_object\_version) | A unique version ID value for the log forwarder lambda zip object, if bucket versioning is enabled |
| <a name="output_metrics_endpoint_arn"></a> [metrics\_endpoint\_arn](#output\_metrics\_endpoint\_arn) | ARN of the metrics VPC endpoint |
| <a name="output_metrics_endpoint_dns_entry"></a> [metrics\_endpoint\_dns\_entry](#output\_metrics\_endpoint\_dns\_entry) | DNS entries of the metrics VPC endpoint |
| <a name="output_metrics_endpoint_id"></a> [metrics\_endpoint\_id](#output\_metrics\_endpoint\_id) | ID of the metrics VPC endpoint |
| <a name="output_metrics_endpoint_network_interface_ids"></a> [metrics\_endpoint\_network\_interface\_ids](#output\_metrics\_endpoint\_network\_interface\_ids) | One or more network interfaces for the metrics VPC endpoint |
| <a name="output_metrics_endpoint_owner_id"></a> [metrics\_endpoint\_owner\_id](#output\_metrics\_endpoint\_owner\_id) | The ID of the AWS account that owns the metrics VPC endpoint |
| <a name="output_metrics_endpoint_state"></a> [metrics\_endpoint\_state](#output\_metrics\_endpoint\_state) | The state of the metrics VPC endpoint |
| <a name="output_processes_endpoint_arn"></a> [processes\_endpoint\_arn](#output\_processes\_endpoint\_arn) | ARN of the processes VPC endpoint |
| <a name="output_processes_endpoint_dns_entry"></a> [processes\_endpoint\_dns\_entry](#output\_processes\_endpoint\_dns\_entry) | DNS entries of the processes VPC endpoint |
| <a name="output_processes_endpoint_id"></a> [processes\_endpoint\_id](#output\_processes\_endpoint\_id) | ID of the processes VPC endpoint |
| <a name="output_processes_endpoint_network_interface_ids"></a> [processes\_endpoint\_network\_interface\_ids](#output\_processes\_endpoint\_network\_interface\_ids) | One or more network interfaces for the processes VPC endpoint |
| <a name="output_processes_endpoint_owner_id"></a> [processes\_endpoint\_owner\_id](#output\_processes\_endpoint\_owner\_id) | The ID of the AWS account that owns the processes VPC endpoint |
| <a name="output_processes_endpoint_state"></a> [processes\_endpoint\_state](#output\_processes\_endpoint\_state) | The state of the processes VPC endpoint |
| <a name="output_rds_em_forwarder_cloudwatch_log_group_arn"></a> [rds\_em\_forwarder\_cloudwatch\_log\_group\_arn](#output\_rds\_em\_forwarder\_cloudwatch\_log\_group\_arn) | The ARN of the RDS enhanced monitoring forwarder lambda function CloudWatch log group |
| <a name="output_rds_em_forwarder_lambda_arn"></a> [rds\_em\_forwarder\_lambda\_arn](#output\_rds\_em\_forwarder\_lambda\_arn) | The ARN of the RDS enhanced monitoring forwarder lambda function |
| <a name="output_rds_em_forwarder_lambda_kms_key_arn"></a> [rds\_em\_forwarder\_lambda\_kms\_key\_arn](#output\_rds\_em\_forwarder\_lambda\_kms\_key\_arn) | (Optional) The ARN for the KMS encryption key for the RDS enhanced monitoring forwarder lambda function |
| <a name="output_rds_em_forwarder_lambda_qualified_arn"></a> [rds\_em\_forwarder\_lambda\_qualified\_arn](#output\_rds\_em\_forwarder\_lambda\_qualified\_arn) | The ARN of the RDS enhanced monitoring forwarder lambda function (if versioning is enabled via publish = true) |
| <a name="output_rds_em_forwarder_lambda_source_code_hash"></a> [rds\_em\_forwarder\_lambda\_source\_code\_hash](#output\_rds\_em\_forwarder\_lambda\_source\_code\_hash) | Base64-encoded representation of raw SHA-256 sum of the RDS enhanced monitoring lambda forwarder zip file, provided either via filename or s3\_* parameters |
| <a name="output_rds_em_forwarder_lambda_version"></a> [rds\_em\_forwarder\_lambda\_version](#output\_rds\_em\_forwarder\_lambda\_version) | Latest published version of the RDS enhanced monitoring forwarder lambda function |
| <a name="output_rds_em_forwarder_role_arn"></a> [rds\_em\_forwarder\_role\_arn](#output\_rds\_em\_forwarder\_role\_arn) | The RDS enhanced monitoring forwarder lambda role arn |
| <a name="output_rds_em_forwarder_role_id"></a> [rds\_em\_forwarder\_role\_id](#output\_rds\_em\_forwarder\_role\_id) | The RDS enhanced monitoring forwarder lambda role id |
| <a name="output_rds_em_forwarder_role_name"></a> [rds\_em\_forwarder\_role\_name](#output\_rds\_em\_forwarder\_role\_name) | The RDS enhanced monitoring forwarder lambda role name |
| <a name="output_rds_em_forwarder_role_policy_arn"></a> [rds\_em\_forwarder\_role\_policy\_arn](#output\_rds\_em\_forwarder\_role\_policy\_arn) | The ARN of the RDS enhanced monitoring forwarder lambda role policy |
| <a name="output_rds_em_forwarder_role_policy_id"></a> [rds\_em\_forwarder\_role\_policy\_id](#output\_rds\_em\_forwarder\_role\_policy\_id) | The ID of the RDS enhanced monitoring forwarder lambda role policy |
| <a name="output_rds_em_forwarder_role_policy_name"></a> [rds\_em\_forwarder\_role\_policy\_name](#output\_rds\_em\_forwarder\_role\_policy\_name) | The name of the RDS enhanced monitoring forwarder lambda role policy |
| <a name="output_rds_em_forwarder_role_unique_id"></a> [rds\_em\_forwarder\_role\_unique\_id](#output\_rds\_em\_forwarder\_role\_unique\_id) | The stable and unique string identifying the RDS enhanced monitoring forwarder lambda role. |
| <a name="output_traces_endpoint_arn"></a> [traces\_endpoint\_arn](#output\_traces\_endpoint\_arn) | ARN of the traces VPC endpoint |
| <a name="output_traces_endpoint_dns_entry"></a> [traces\_endpoint\_dns\_entry](#output\_traces\_endpoint\_dns\_entry) | DNS entries of the traces VPC endpoint |
| <a name="output_traces_endpoint_id"></a> [traces\_endpoint\_id](#output\_traces\_endpoint\_id) | ID of the traces VPC endpoint |
| <a name="output_traces_endpoint_network_interface_ids"></a> [traces\_endpoint\_network\_interface\_ids](#output\_traces\_endpoint\_network\_interface\_ids) | One or more network interfaces for the traces VPC endpoint |
| <a name="output_traces_endpoint_owner_id"></a> [traces\_endpoint\_owner\_id](#output\_traces\_endpoint\_owner\_id) | The ID of the AWS account that owns the traces VPC endpoint |
| <a name="output_traces_endpoint_state"></a> [traces\_endpoint\_state](#output\_traces\_endpoint\_state) | The state of the traces VPC endpoint |
| <a name="output_vpc_fl_forwarder_cloudwatch_log_group_arn"></a> [vpc\_fl\_forwarder\_cloudwatch\_log\_group\_arn](#output\_vpc\_fl\_forwarder\_cloudwatch\_log\_group\_arn) | The ARN of the VPC flow log forwarder lambda function CloudWatch log group |
| <a name="output_vpc_fl_forwarder_lambda_arn"></a> [vpc\_fl\_forwarder\_lambda\_arn](#output\_vpc\_fl\_forwarder\_lambda\_arn) | The ARN of the VPC flow log forwarder lambda function |
| <a name="output_vpc_fl_forwarder_lambda_kms_key_arn"></a> [vpc\_fl\_forwarder\_lambda\_kms\_key\_arn](#output\_vpc\_fl\_forwarder\_lambda\_kms\_key\_arn) | (Optional) The ARN for the KMS encryption key for the VPC flow log forwarder lambda function |
| <a name="output_vpc_fl_forwarder_lambda_qualified_arn"></a> [vpc\_fl\_forwarder\_lambda\_qualified\_arn](#output\_vpc\_fl\_forwarder\_lambda\_qualified\_arn) | The ARN of the VPC flow log forwarder lambda function (if versioning is enabled via publish = true) |
| <a name="output_vpc_fl_forwarder_lambda_source_code_hash"></a> [vpc\_fl\_forwarder\_lambda\_source\_code\_hash](#output\_vpc\_fl\_forwarder\_lambda\_source\_code\_hash) | Base64-encoded representation of raw SHA-256 sum of the VPC flow log forwarder lambda zip file, provided either via filename or s3\_* parameters |
| <a name="output_vpc_fl_forwarder_lambda_version"></a> [vpc\_fl\_forwarder\_lambda\_version](#output\_vpc\_fl\_forwarder\_lambda\_version) | Latest published version of the VPC flow log forwarder lambda function |
| <a name="output_vpc_fl_forwarder_role_arn"></a> [vpc\_fl\_forwarder\_role\_arn](#output\_vpc\_fl\_forwarder\_role\_arn) | The VPC flow log forwarder lambda role arn |
| <a name="output_vpc_fl_forwarder_role_id"></a> [vpc\_fl\_forwarder\_role\_id](#output\_vpc\_fl\_forwarder\_role\_id) | The VPC flow log forwarder lambda role id |
| <a name="output_vpc_fl_forwarder_role_name"></a> [vpc\_fl\_forwarder\_role\_name](#output\_vpc\_fl\_forwarder\_role\_name) | The VPC flow log forwarder lambda role name |
| <a name="output_vpc_fl_forwarder_role_policy_arn"></a> [vpc\_fl\_forwarder\_role\_policy\_arn](#output\_vpc\_fl\_forwarder\_role\_policy\_arn) | The ARN of the VPC flow log forwarder lambda role policy |
| <a name="output_vpc_fl_forwarder_role_policy_id"></a> [vpc\_fl\_forwarder\_role\_policy\_id](#output\_vpc\_fl\_forwarder\_role\_policy\_id) | The ID of the VPC flow log forwarder lambda role policy |
| <a name="output_vpc_fl_forwarder_role_policy_name"></a> [vpc\_fl\_forwarder\_role\_policy\_name](#output\_vpc\_fl\_forwarder\_role\_policy\_name) | The name of the VPC flow log forwarder lambda role policy |
| <a name="output_vpc_fl_forwarder_role_unique_id"></a> [vpc\_fl\_forwarder\_role\_unique\_id](#output\_vpc\_fl\_forwarder\_role\_unique\_id) | The stable and unique string identifying the VPC flow log forwarder lambda role. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed. See [LICENSE](LICENSE).
