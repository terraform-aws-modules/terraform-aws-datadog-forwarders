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

## Terraform versions

Terraform 0.12 and above are supported.

## Usage

```hcl
# Note: you will need to create this secret manually prior to running
# This avoids having to pass the key to Terraform in plaintext
data "aws_secretsmanager_secret" "datadog_api_key" {
  name = "datadog/api_key"
}

module "datadog_forwarders" {
  source = "git::https://github.com/clowdhaus/terraform-aws-datadog-forwarders.git?ref=master"

  kms_alias             = "alias/datadog" # KMS key will need to be created outside of module
  dd_api_key_secret_arn = data.aws_secretsmanager_secret.datadog_api_key.arn

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Examples

- [Complete](./examples/complete)
- [Simple](./examples/simple)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.26, < 0.14 |
| aws | >= 3.0, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.0, < 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| agent\_vpce\_policy | Policy to attach to the agent endpoint that controls access to the service. Defaults to full access | `any` | `null` | no |
| agent\_vpce\_security\_group\_ids | IDs of security groups to attach to agent endpoint | `list(string)` | `[]` | no |
| agent\_vpce\_subnet\_ids | IDs of subnets to associate with agent endpoint | `list(string)` | `[]` | no |
| agent\_vpce\_tags | A map of tags to apply to the Datadog agent endpoint | `map(string)` | `{}` | no |
| api\_vpce\_policy | Policy to attach to the API endpoint that controls access to the service. Defaults to full access | `any` | `null` | no |
| api\_vpce\_security\_group\_ids | IDs of security groups to attach to API endpoint | `list(string)` | `[]` | no |
| api\_vpce\_subnet\_ids | IDs of subnets to associate with API endpoint | `list(string)` | `[]` | no |
| api\_vpce\_tags | A map of tags to apply to the API endpoint | `map(string)` | `{}` | no |
| bucket\_name | Lambda artifact S3 bucket name | `string` | `""` | no |
| create\_agent\_vpce | Controls whether an agent endpoint should be created | `bool` | `false` | no |
| create\_api\_vpce | Controls whether a API endpoint should be created | `bool` | `false` | no |
| create\_bucket | Controls whether an S3 artifact bucket should be created. this is used for the zip archive as well as caching tags | `bool` | `true` | no |
| create\_log\_forwarder | Controls whether log forwarder resources should be created | `bool` | `true` | no |
| create\_log\_forwarder\_vpce | Controls whether a log forwarder endpoint should be created | `bool` | `false` | no |
| create\_metrics\_vpce | Controls whether a metrics VPC endpoint should be created | `bool` | `false` | no |
| create\_processes\_vpce | Controls whether a processes endpoint should be created | `bool` | `false` | no |
| create\_rds\_em\_forwarder | Controls whether RDS enhanced monitoring forwarder resources should be created | `bool` | `true` | no |
| create\_traces\_vpce | Controls whether a traces endpoint should be created | `bool` | `false` | no |
| create\_vpc\_fl\_forwarder | Controls whether VPC flow log forwarder resources should be created | `bool` | `true` | no |
| dd\_api\_key | The Datadog API key, which can be found from the APIs page (/account/settings#api). It will be stored in AWS Secrets Manager securely. If DdApiKeySecretArn is also set, this value will not be used. This value must still be set, however | `string` | `""` | no |
| dd\_api\_key\_secret\_arn | The ARN of the Secrets Manager secret storing the Datadog API key, if you already have it stored in Secrets Manager. You still need to set a dummy value for `dd_api_key` to satisfy the requirement, though that value won't be used | `string` | `""` | no |
| dd\_app\_key | The Datadog application key associated with the user account that created it, which can be found from the APIs page | `string` | `""` | no |
| dd\_site | Define your Datadog Site to send data to. For the Datadog EU site, set to datadoghq.eu | `string` | `"datadoghq.com"` | no |
| kms\_alias | Alias of KMS key used to encrypt the Datadog API keys - must start with `alias/` | `string` | n/a | yes |
| log\_forwarder\_bucket\_prefix | S3 object key prefix to prepend to zip archive name | `string` | `""` | no |
| log\_forwarder\_environment\_variables | A map of environment variables for the log forwarder lambda function | `map(string)` | `{}` | no |
| log\_forwarder\_kms\_key\_arn | KMS key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key | `string` | `null` | no |
| log\_forwarder\_lambda\_tags | A map of tags to apply to the log forwarder lambda function | `map(string)` | `{}` | no |
| log\_forwarder\_layers | List of Lambda Layer Version ARNs (maximum of 5) to attach to the log forwarder lambda | `list(string)` | `[]` | no |
| log\_forwarder\_log\_retention\_days | Log forwarder CloudWatch log group retention in days | `number` | `7` | no |
| log\_forwarder\_memory\_size | Memory size for the log forwarder lambda function | `number` | `1024` | no |
| log\_forwarder\_name | Log forwarder lambda name | `string` | `"datadog-log-forwarder"` | no |
| log\_forwarder\_policy\_arn | IAM policy arn for log forwarder lambda function to utilize | `string` | `""` | no |
| log\_forwarder\_policy\_name | Log forwarder policy name | `string` | `""` | no |
| log\_forwarder\_policy\_path | Log forwarder policy path | `string` | `null` | no |
| log\_forwarder\_publish | Whether to publish creation/change as a new Lambda Function Version | `bool` | `false` | no |
| log\_forwarder\_reserved\_concurrent\_executions | The amount of reserved concurrent executions for the log forwarder lambda function | `number` | `100` | no |
| log\_forwarder\_role\_arn | IAM role arn for log forwarder lambda function to utilize | `string` | `""` | no |
| log\_forwarder\_role\_max\_session\_duration | The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours. | `number` | `null` | no |
| log\_forwarder\_role\_name | Log forwarder role name | `string` | `""` | no |
| log\_forwarder\_role\_path | Log forwarder role path | `string` | `null` | no |
| log\_forwarder\_role\_permissions\_boundary | The ARN of the policy that is used to set the permissions boundary for the log forwarder role. | `string` | `null` | no |
| log\_forwarder\_role\_tags | A map of tags to apply to the log forwarder role | `map(string)` | `{}` | no |
| log\_forwarder\_runtime | Lambda function runtime | `string` | `"python3.7"` | no |
| log\_forwarder\_s3\_log\_bucket\_arns | S3 log buckets for forwarder to read and forward logs to Datadog | `list(string)` | `[]` | no |
| log\_forwarder\_s3\_zip\_kms\_key\_id | The AWS KMS Key ARN to use for object encryption | `string` | `null` | no |
| log\_forwarder\_s3\_zip\_metadata | A map of keys/values to provision metadata (will be automatically prefixed by `x-amz-meta-` | `map(string)` | `{}` | no |
| log\_forwarder\_s3\_zip\_server\_side\_encryption | Server-side encryption of the zip object in S3. Valid values are `AES256` and `aws:kms` | `string` | `null` | no |
| log\_forwarder\_s3\_zip\_storage\_class | Specifies the desired Storage Class for the zip object. Can be either `STANDARD`, `REDUCED_REDUNDANCY`, `ONEZONE_IA`, `INTELLIGENT_TIERING`, or `STANDARD_IA` | `string` | `null` | no |
| log\_forwarder\_s3\_zip\_tags | A map of tags to apply to the zip archive in S3 | `map(string)` | `{}` | no |
| log\_forwarder\_security\_group\_ids | List of security group ids when forwarder lambda function should run in the VPC. | `list(string)` | `null` | no |
| log\_forwarder\_subnet\_ids | List of subnet ids when forwarder lambda function should run in the VPC. Usually private or intra subnets. | `list(string)` | `null` | no |
| log\_forwarder\_tags | A map of tags to apply to the log forwarder resources | `map(string)` | `{}` | no |
| log\_forwarder\_timeout | The amount of time the log forwarder lambda has to execute in seconds | `number` | `120` | no |
| log\_forwarder\_use\_policy\_name\_prefix | Whether to use unique name beginning with the specified `policy_name` for the log forwarder policy | `bool` | `false` | no |
| log\_forwarder\_use\_role\_name\_prefix | Whether to use unique name beginning with the specified `role_name` for the log forwarder role | `bool` | `false` | no |
| log\_forwarder\_version | Forwarder version - see https://github.com/DataDog/datadog-serverless-functions/releases | `string` | `"3.21.0"` | no |
| log\_forwarder\_vpce\_policy | Policy to attach to the log forwarder endpoint that controls access to the service. Defaults to full access | `any` | `null` | no |
| log\_forwarder\_vpce\_security\_group\_ids | IDs of security groups to attach to log forwarder endpoint | `list(string)` | `[]` | no |
| log\_forwarder\_vpce\_subnet\_ids | IDs of subnets to associate with log forwarder endpoint | `list(string)` | `[]` | no |
| log\_forwarder\_vpce\_tags | A map of tags to apply to the log forwarder endpoint | `map(string)` | `{}` | no |
| metrics\_vpce\_policy | Policy to attach to the metrics endpoint that controls access to the service. Defaults to full access | `any` | `null` | no |
| metrics\_vpce\_security\_group\_ids | IDs of security groups to attach to metrics endpoint | `list(string)` | `[]` | no |
| metrics\_vpce\_subnet\_ids | IDs of subnets to associate with metrics endpoint | `list(string)` | `[]` | no |
| metrics\_vpce\_tags | A map of tags to apply to the metrics endpoint | `map(string)` | `{}` | no |
| processes\_vpce\_policy | Policy to attach to the processes endpoint that controls access to the service. Defaults to full access | `any` | `null` | no |
| processes\_vpce\_security\_group\_ids | IDs of security groups to attach to processes endpoint | `list(string)` | `[]` | no |
| processes\_vpce\_subnet\_ids | IDs of subnets to associate with processes endpoint | `list(string)` | `[]` | no |
| processes\_vpce\_tags | A map of tags to apply to the processes endpoint | `map(string)` | `{}` | no |
| rds\_em\_forwarder\_environment\_variables | A map of environment variables for the RDS enhanced monitoring forwarder lambda function | `map(string)` | `{}` | no |
| rds\_em\_forwarder\_kms\_key\_arn | KMS key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key | `string` | `null` | no |
| rds\_em\_forwarder\_lambda\_tags | A map of tags to apply to the RDS enhanced monitoring forwarder lambda function | `map(string)` | `{}` | no |
| rds\_em\_forwarder\_layers | List of Lambda Layer Version ARNs (maximum of 5) to attach to the RDS enhanced monitoring forwarder lambda | `list(string)` | `[]` | no |
| rds\_em\_forwarder\_log\_retention\_days | RDS enhanced monitoring forwarder CloudWatch log group retention in days | `number` | `7` | no |
| rds\_em\_forwarder\_memory\_size | Memory size for the RDS enhanced monitoring forwarder lambda function | `number` | `256` | no |
| rds\_em\_forwarder\_name | RDS enhanced monitoring forwarder lambda name | `string` | `"datadog-rds-enhanced-monitoring-forwarder"` | no |
| rds\_em\_forwarder\_policy\_arn | IAM policy arn for RDS enhanced monitoring forwarder lambda function to utilize | `string` | `""` | no |
| rds\_em\_forwarder\_policy\_name | RDS enhanced monitoring forwarder policy name | `string` | `""` | no |
| rds\_em\_forwarder\_policy\_path | RDS enhanced monitoring forwarder policy path | `string` | `null` | no |
| rds\_em\_forwarder\_publish | Whether to publish creation/change as a new fambda function Version | `bool` | `false` | no |
| rds\_em\_forwarder\_reserved\_concurrent\_executions | The amount of reserved concurrent executions for the RDS enhanced monitoring forwarder lambda function | `number` | `10` | no |
| rds\_em\_forwarder\_role\_arn | IAM role arn for RDS enhanced monitoring forwarder lambda function to utilize | `string` | `""` | no |
| rds\_em\_forwarder\_role\_max\_session\_duration | The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours. | `number` | `null` | no |
| rds\_em\_forwarder\_role\_name | RDS enhanced monitoring forwarder role name | `string` | `""` | no |
| rds\_em\_forwarder\_role\_path | RDS enhanced monitoring forwarder role path | `string` | `null` | no |
| rds\_em\_forwarder\_role\_permissions\_boundary | The ARN of the policy that is used to set the permissions boundary for the RDS enhanced monitoring forwarder role | `string` | `null` | no |
| rds\_em\_forwarder\_role\_tags | A map of tags to apply to the RDS enhanced monitoring forwarder role | `map(string)` | `{}` | no |
| rds\_em\_forwarder\_runtime | Lambda function runtime | `string` | `"python3.7"` | no |
| rds\_em\_forwarder\_security\_group\_ids | List of security group ids when forwarder lambda function should run in the VPC. | `list(string)` | `null` | no |
| rds\_em\_forwarder\_subnet\_ids | List of subnet ids when forwarder lambda function should run in the VPC. Usually private or intra subnets. | `list(string)` | `null` | no |
| rds\_em\_forwarder\_tags | A map of tags to apply to the RDS enhanced monitoring forwarder resources | `map(string)` | `{}` | no |
| rds\_em\_forwarder\_timeout | The amount of time the RDS enhanced monitoring forwarder lambda has to execute in seconds | `number` | `10` | no |
| rds\_em\_forwarder\_use\_policy\_name\_prefix | Whether to use unique name beginning with the specified `rds_em_forwarder_policy_name` for the RDS enhanced monitoring forwarder role | `bool` | `false` | no |
| rds\_em\_forwarder\_use\_role\_name\_prefix | Whether to use unique name beginning with the specified `rds_em_forwarder_role_name` for the RDS enhanced monitoring forwarder role | `bool` | `false` | no |
| rds\_em\_forwarder\_version | RDS enhanced monitoring lambda version - see https://github.com/DataDog/datadog-serverless-functions/releases | `string` | `"3.21.0"` | no |
| tags | A map of tags to use on all resources | `map(string)` | `{}` | no |
| traces\_vpce\_policy | Policy to attach to the traces endpoint that controls access to the service. Defaults to full access | `any` | `null` | no |
| traces\_vpce\_security\_group\_ids | IDs of security groups to attach to traces endpoint | `list(string)` | `[]` | no |
| traces\_vpce\_subnet\_ids | IDs of subnets to associate with traces endpoint | `list(string)` | `[]` | no |
| traces\_vpce\_tags | A map of tags to apply to the traces endpoint | `map(string)` | `{}` | no |
| vpc\_fl\_forwarder\_environment\_variables | A map of environment variables for the VPC flow log forwarder lambda function | `map(string)` | `{}` | no |
| vpc\_fl\_forwarder\_kms\_key\_arn | KMS key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key | `string` | `null` | no |
| vpc\_fl\_forwarder\_lambda\_tags | A map of tags to apply to the VPC flow log forwarder lambda function | `map(string)` | `{}` | no |
| vpc\_fl\_forwarder\_layers | List of Lambda Layer Version ARNs (maximum of 5) to attach to the VPC flow log forwarder lambda | `list(string)` | `[]` | no |
| vpc\_fl\_forwarder\_log\_retention\_days | VPC flow log forwarder CloudWatch log group retention in days | `number` | `7` | no |
| vpc\_fl\_forwarder\_memory\_size | Memory size for the VPC flow log forwarder lambda function | `number` | `256` | no |
| vpc\_fl\_forwarder\_name | VPC flow log forwarder lambda name | `string` | `"datadog-vpc-flow-log-forwarder"` | no |
| vpc\_fl\_forwarder\_policy\_arn | IAM policy arn for VPC flow log forwarder lambda function to utilize | `string` | `""` | no |
| vpc\_fl\_forwarder\_policy\_name | VPC flow log forwarder policy name | `string` | `""` | no |
| vpc\_fl\_forwarder\_policy\_path | VPC flow log forwarder policy path | `string` | `null` | no |
| vpc\_fl\_forwarder\_publish | Whether to publish creation/change as a new fambda function Version | `bool` | `false` | no |
| vpc\_fl\_forwarder\_read\_cloudwatch\_logs | Whether the VPC flow log forwarder will read CloudWatch log groups for VPC flow logs | `bool` | `false` | no |
| vpc\_fl\_forwarder\_reserved\_concurrent\_executions | The amount of reserved concurrent executions for the VPC flow log forwarder lambda function | `number` | `10` | no |
| vpc\_fl\_forwarder\_role\_arn | IAM role arn for VPC flow log forwarder lambda function to utilize | `string` | `""` | no |
| vpc\_fl\_forwarder\_role\_max\_session\_duration | The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours. | `number` | `null` | no |
| vpc\_fl\_forwarder\_role\_name | VPC flow log forwarder role name | `string` | `""` | no |
| vpc\_fl\_forwarder\_role\_path | VPC flow log forwarder role path | `string` | `null` | no |
| vpc\_fl\_forwarder\_role\_permissions\_boundary | The ARN of the policy that is used to set the permissions boundary for the VPC flow log forwarder role | `string` | `null` | no |
| vpc\_fl\_forwarder\_role\_tags | A map of tags to apply to the VPC flow log forwarder role | `map(string)` | `{}` | no |
| vpc\_fl\_forwarder\_runtime | Lambda function runtime | `string` | `"python2.7"` | no |
| vpc\_fl\_forwarder\_s3\_log\_bucket\_arns | S3 log buckets for VPC flow log forwarder to read and forward to Datadog | `list(string)` | `[]` | no |
| vpc\_fl\_forwarder\_security\_group\_ids | List of security group ids when forwarder lambda function should run in the VPC. | `list(string)` | `null` | no |
| vpc\_fl\_forwarder\_subnet\_ids | List of subnet ids when forwarder lambda function should run in the VPC. Usually private or intra subnets. | `list(string)` | `null` | no |
| vpc\_fl\_forwarder\_tags | A map of tags to apply to the VPC flow log forwarder resources | `map(string)` | `{}` | no |
| vpc\_fl\_forwarder\_timeout | The amount of time the VPC flow log forwarder lambda has to execute in seconds | `number` | `10` | no |
| vpc\_fl\_forwarder\_use\_policy\_name\_prefix | Whether to use unique name beginning with the specified `vpc_fl_forwarder_policy_name` for the VPC flow log forwarder role | `bool` | `false` | no |
| vpc\_fl\_forwarder\_use\_role\_name\_prefix | Whether to use unique name beginning with the specified `vpc_fl_forwarder_role_name` for the VPC flow log forwarder role | `bool` | `false` | no |
| vpc\_fl\_forwarder\_version | VPC flow log lambda version - see https://github.com/DataDog/datadog-serverless-functions/releases | `string` | `"3.21.0"` | no |
| vpc\_id | ID of VPC to provision endpoints within | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| agent\_endpoint\_arn | ARN of the agent VPC endpoint |
| agent\_endpoint\_dns\_entry | DNS entries of the agent VPC endpoint |
| agent\_endpoint\_id | ID of the agent VPC endpoint |
| agent\_endpoint\_network\_interface\_ids | One or more network interfaces for the agent VPC endpoint |
| agent\_endpoint\_owner\_id | The ID of the AWS account that owns the agent VPC endpoint |
| agent\_endpoint\_state | The state of the agent VPC endpoint |
| api\_endpoint\_arn | ARN of the API VPC endpoint |
| api\_endpoint\_dns\_entry | DNS entries of the API VPC endpoint |
| api\_endpoint\_id | ID of the API VPC endpoint |
| api\_endpoint\_network\_interface\_ids | One or more network interfaces for API api VPC endpoint |
| api\_endpoint\_owner\_id | The ID of the AWS account that owns the API VPC endpoint |
| api\_endpoint\_state | The state of the API VPC endpoint |
| log\_forwarder\_cloudwatch\_log\_group\_arn | The ARN of the log forwarder lambda function CloudWatch log group |
| log\_forwarder\_endpoint\_arn | ARN of the log forwarder VPC endpoint |
| log\_forwarder\_endpoint\_dns\_entry | DNS entries of the log forwarder VPC endpoint |
| log\_forwarder\_endpoint\_id | ID of the log forwarder VPC endpoint |
| log\_forwarder\_endpoint\_network\_interface\_ids | One or more network interfaces for the log forwarder VPC endpoint |
| log\_forwarder\_endpoint\_owner\_id | The ID of the AWS account that owns the log forwarder VPC endpoint |
| log\_forwarder\_endpoint\_state | The state of the log forwarder VPC endpoint |
| log\_forwarder\_lambda\_arn | The ARN of the log forwarder lambda function |
| log\_forwarder\_lambda\_kms\_key\_arn | (Optional) The ARN for the KMS encryption key for the log forwarder lambda function |
| log\_forwarder\_lambda\_qualified\_arn | The ARN of the log forwarder lambda function (if versioning is enabled via publish = true) |
| log\_forwarder\_lambda\_source\_code\_hash | Base64-encoded representation of raw SHA-256 sum of the log forwarder zip file, provided either via filename or s3\_\* parameters |
| log\_forwarder\_lambda\_version | Latest published version of the log forwarder lambda function |
| log\_forwarder\_role\_arn | The log forwarder lambda role arn |
| log\_forwarder\_role\_id | The log forwarder lambda role id |
| log\_forwarder\_role\_name | The log forwarder lambda role name |
| log\_forwarder\_role\_policy\_arn | The ARN of the log forwarder lambda role policy |
| log\_forwarder\_role\_policy\_id | The ID of the log forwarder lambda role policy |
| log\_forwarder\_role\_policy\_name | The name of the log forwarder lambda role policy |
| log\_forwarder\_role\_unique\_id | The stable and unique string identifying the log forwarder lambda role |
| log\_forwarder\_s3\_bucket\_arn | The ARN of the log forwarder bucket. Will be of format arn:aws:s3:::bucketname |
| log\_forwarder\_s3\_bucket\_domain\_name | The log forwarder bucket domain name. Will be of format bucketname.s3.amazonaws.com |
| log\_forwarder\_s3\_bucket\_id | The name of the log forwarder bucket |
| log\_forwarder\_s3\_bucket\_regional\_domain\_name | The log forwarder bucket region-specific domain name. The bucket domain name including the region name |
| log\_forwarder\_s3\_object\_etag | The ETag generated for the log forwarder lambda zip object (an MD5 sum of the object content) |
| log\_forwarder\_s3\_object\_id | The `key` of the log forwarder lambda zip archive |
| log\_forwarder\_s3\_object\_version | A unique version ID value for the log forwarder lambda zip object, if bucket versioning is enabled |
| metrics\_endpoint\_arn | ARN of the metrics VPC endpoint |
| metrics\_endpoint\_dns\_entry | DNS entries of the metrics VPC endpoint |
| metrics\_endpoint\_id | ID of the metrics VPC endpoint |
| metrics\_endpoint\_network\_interface\_ids | One or more network interfaces for the metrics VPC endpoint |
| metrics\_endpoint\_owner\_id | The ID of the AWS account that owns the metrics VPC endpoint |
| metrics\_endpoint\_state | The state of the metrics VPC endpoint |
| processes\_endpoint\_arn | ARN of the processes VPC endpoint |
| processes\_endpoint\_dns\_entry | DNS entries of the processes VPC endpoint |
| processes\_endpoint\_id | ID of the processes VPC endpoint |
| processes\_endpoint\_network\_interface\_ids | One or more network interfaces for the processes VPC endpoint |
| processes\_endpoint\_owner\_id | The ID of the AWS account that owns the processes VPC endpoint |
| processes\_endpoint\_state | The state of the processes VPC endpoint |
| rds\_em\_forwarder\_cloudwatch\_log\_group\_arn | The ARN of the RDS enhanced monitoring forwarder lambda function CloudWatch log group |
| rds\_em\_forwarder\_lambda\_arn | The ARN of the RDS enhanced monitoring forwarder lambda function |
| rds\_em\_forwarder\_lambda\_kms\_key\_arn | (Optional) The ARN for the KMS encryption key for the RDS enhanced monitoring forwarder lambda function |
| rds\_em\_forwarder\_lambda\_qualified\_arn | The ARN of the RDS enhanced monitoring forwarder lambda function (if versioning is enabled via publish = true) |
| rds\_em\_forwarder\_lambda\_source\_code\_hash | Base64-encoded representation of raw SHA-256 sum of the RDS enhanced monitoring lambda forwarder zip file, provided either via filename or s3\_\* parameters |
| rds\_em\_forwarder\_lambda\_version | Latest published version of the RDS enhanced monitoring forwarder lambda function |
| rds\_em\_forwarder\_role\_arn | The RDS enhanced monitoring forwarder lambda role arn |
| rds\_em\_forwarder\_role\_id | The RDS enhanced monitoring forwarder lambda role id |
| rds\_em\_forwarder\_role\_name | The RDS enhanced monitoring forwarder lambda role name |
| rds\_em\_forwarder\_role\_policy\_arn | The ARN of the RDS enhanced monitoring forwarder lambda role policy |
| rds\_em\_forwarder\_role\_policy\_id | The ID of the RDS enhanced monitoring forwarder lambda role policy |
| rds\_em\_forwarder\_role\_policy\_name | The name of the RDS enhanced monitoring forwarder lambda role policy |
| rds\_em\_forwarder\_role\_unique\_id | The stable and unique string identifying the RDS enhanced monitoring forwarder lambda role. |
| traces\_endpoint\_arn | ARN of the traces VPC endpoint |
| traces\_endpoint\_dns\_entry | DNS entries of the traces VPC endpoint |
| traces\_endpoint\_id | ID of the traces VPC endpoint |
| traces\_endpoint\_network\_interface\_ids | One or more network interfaces for the traces VPC endpoint |
| traces\_endpoint\_owner\_id | The ID of the AWS account that owns the traces VPC endpoint |
| traces\_endpoint\_state | The state of the traces VPC endpoint |
| vpc\_fl\_forwarder\_cloudwatch\_log\_group\_arn | The ARN of the VPC flow log forwarder lambda function CloudWatch log group |
| vpc\_fl\_forwarder\_lambda\_arn | The ARN of the VPC flow log forwarder lambda function |
| vpc\_fl\_forwarder\_lambda\_kms\_key\_arn | (Optional) The ARN for the KMS encryption key for the VPC flow log forwarder lambda function |
| vpc\_fl\_forwarder\_lambda\_qualified\_arn | The ARN of the VPC flow log forwarder lambda function (if versioning is enabled via publish = true) |
| vpc\_fl\_forwarder\_lambda\_source\_code\_hash | Base64-encoded representation of raw SHA-256 sum of the VPC flow log forwarder lambda zip file, provided either via filename or s3\_\* parameters |
| vpc\_fl\_forwarder\_lambda\_version | Latest published version of the VPC flow log forwarder lambda function |
| vpc\_fl\_forwarder\_role\_arn | The VPC flow log forwarder lambda role arn |
| vpc\_fl\_forwarder\_role\_id | The VPC flow log forwarder lambda role id |
| vpc\_fl\_forwarder\_role\_name | The VPC flow log forwarder lambda role name |
| vpc\_fl\_forwarder\_role\_policy\_arn | The ARN of the VPC flow log forwarder lambda role policy |
| vpc\_fl\_forwarder\_role\_policy\_id | The ID of the VPC flow log forwarder lambda role policy |
| vpc\_fl\_forwarder\_role\_policy\_name | The name of the VPC flow log forwarder lambda role policy |
| vpc\_fl\_forwarder\_role\_unique\_id | The stable and unique string identifying the VPC flow log forwarder lambda role. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed. See [LICENSE](LICENSE).
