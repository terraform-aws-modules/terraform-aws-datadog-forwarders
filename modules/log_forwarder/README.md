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
| terraform | >= 0.12.26 |
| aws | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.0 |
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bucket\_name | Forwarder S3 bucket name | `string` | `""` | no |
| bucket\_prefix | S3 object key prefix to prepend to zip archive name | `string` | `""` | no |
| create | Controls whether the forwarder resources should be created | `bool` | `true` | no |
| create\_bucket | Controls whether an S3 bucket should be created for the forwarder | `bool` | `true` | no |
| dd\_api\_key | The Datadog API key, which can be found from the APIs page (/account/settings#api). It will be stored in AWS Secrets Manager securely | `string` | `""` | no |
| dd\_api\_key\_secret\_arn | The ARN of the Secrets Manager secret storing the Datadog API key, if you already have it stored in Secrets Manager | `string` | `""` | no |
| dd\_site | Define your Datadog Site to send data to. For the Datadog EU site, set to datadoghq.eu | `string` | `"datadoghq.com"` | no |
| environment\_variables | A map of environment variables for the forwarder lambda function | `map(string)` | `{}` | no |
| forwarder\_version | Forwarder version - see https://github.com/DataDog/datadog-serverless-functions/releases | `string` | `"3.28.1"` | no |
| kms\_key\_arn | KMS key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key | `string` | `null` | no |
| lambda\_tags | A map of tags to apply to the forwarder lambda function | `map(string)` | `{}` | no |
| layers | List of Lambda Layer Version ARNs (maximum of 5) to attach to the forwarder lambda | `list(string)` | `[]` | no |
| log\_retention\_days | Forwarder CloudWatch log group retention in days | `number` | `7` | no |
| memory\_size | Memory size for the forwarder lambda function | `number` | `1024` | no |
| name | Forwarder lambda name | `string` | `"datadog-log-forwarder"` | no |
| policy\_arn | IAM policy arn for forwarder lambda function to utilize | `string` | `""` | no |
| policy\_name | Forwarder policy name | `string` | `""` | no |
| policy\_path | Forwarder policy path | `string` | `null` | no |
| publish | Whether to publish creation/change as a new Lambda Function Version | `bool` | `false` | no |
| read\_cloudwatch\_logs | Whether the forwarder will read logs from CloudWatch or not | `bool` | `false` | no |
| reserved\_concurrent\_executions | The amount of reserved concurrent executions for the forwarder lambda function | `number` | `100` | no |
| role\_arn | IAM role arn for forwarder lambda function to utilize | `string` | `""` | no |
| role\_max\_session\_duration | The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours. | `number` | `null` | no |
| role\_name | Forwarder role name | `string` | `""` | no |
| role\_path | Forwarder role path | `string` | `null` | no |
| role\_permissions\_boundary | The ARN of the policy that is used to set the permissions boundary for the forwarder role. | `string` | `null` | no |
| role\_tags | A map of tags to apply to the forwarder role | `map(string)` | `{}` | no |
| runtime | Lambda function runtime | `string` | `"python3.7"` | no |
| s3\_log\_bucket\_arns | S3 log buckets for forwarder to read and forward logs to Datadog | `list(string)` | `[]` | no |
| s3\_zip\_kms\_key\_id | The AWS KMS Key ARN to use for object encryption | `string` | `null` | no |
| s3\_zip\_metadata | A map of keys/values to provision metadata (will be automatically prefixed by `x-amz-meta-` | `map(string)` | `{}` | no |
| s3\_zip\_server\_side\_encryption | Server-side encryption of the zip object in S3. Valid values are `AES256` and `aws:kms` | `string` | `null` | no |
| s3\_zip\_storage\_class | Specifies the desired Storage Class for the zip object. Can be either `STANDARD`, `REDUCED_REDUNDANCY`, `ONEZONE_IA`, `INTELLIGENT_TIERING`, or `STANDARD_IA` | `string` | `null` | no |
| s3\_zip\_tags | A map of tags to apply to the zip archive in S3 | `map(string)` | `{}` | no |
| security\_group\_ids | List of security group ids when Lambda Function should run in the VPC. | `list(string)` | `null` | no |
| subnet\_ids | List of subnet ids when Lambda Function should run in the VPC. Usually private or intra subnets. | `list(string)` | `null` | no |
| tags | A map of tags to use on all resources | `map(string)` | `{}` | no |
| timeout | The amount of time the forwarder lambda has to execute in seconds | `number` | `120` | no |
| use\_policy\_name\_prefix | Whether to use unique name beginning with the specified `policy_name` for the forwarder policy | `bool` | `false` | no |
| use\_role\_name\_prefix | Whether to use unique name beginning with the specified `role_name` for the forwarder role | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudwatch\_log\_group\_arn | The ARN of the forwarder lambda function CloudWatch log group |
| lambda\_arn | The ARN of the forwarder lambda function |
| lambda\_kms\_key\_arn | (Optional) The ARN for the KMS encryption key for the forwarder lambda function |
| lambda\_qualified\_arn | The ARN of the forwarder lambda function (if versioning is enabled via publish = true) |
| lambda\_source\_code\_hash | Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3\_\* parameters |
| lambda\_version | Latest published version of the forwarder lambda function |
| role\_arn | The forwarder lambda role arn |
| role\_id | The forwarder lambda role id |
| role\_name | The forwarder lambda role name |
| role\_policy\_arn | The ARN of the forwarder lambda role policy |
| role\_policy\_id | The ID of the forwarder lambda role policy |
| role\_policy\_name | The name of the forwarder lambda role policy |
| role\_unique\_id | The stable and unique string identifying the forwarder lambda role |
| s3\_bucket\_arn | The ARN of the bucket. Will be of format arn:aws:s3:::bucketname |
| s3\_bucket\_domain\_name | The bucket domain name. Will be of format bucketname.s3.amazonaws.com |
| s3\_bucket\_id | The name of the bucket |
| s3\_bucket\_regional\_domain\_name | The bucket region-specific domain name. The bucket domain name including the region name |
| s3\_object\_etag | The ETag generated for the forwarder lambda zip object (an MD5 sum of the object content) |
| s3\_object\_id | The `key` of the forwarder lambda zip archive |
| s3\_object\_version | A unique version ID value for the forwarder lambda zip object, if bucket versioning is enabled |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

Apache-2.0 Licensed. See [LICENSE](../../LICENSE).
