# Complete example

Configuration in this directory creates:
- Log forwarder
- RDS enhanced monitoring forwarder
- VPC flow log forwarder
- Metrics, agent, log forwarder, API, processes, and traces PrivateLink VPC endpoints

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
| terraform | >= 0.12.26 |
| aws | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.0 |
| random | n/a |

## Inputs

No input.

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
| log\_forwarder\_lambda\_qualified\_arn | The ARN of the log forwarder lambda function (if versioning is enabled via publish = true) |
| log\_forwarder\_lambda\_source\_code\_hash | Base64-encoded representation of raw SHA-256 sum of the log forwarder zip file, provided either via filename or s3\_\* parameters |
| log\_forwarder\_role\_arn | The log forwarder lambda role arn |
| log\_forwarder\_role\_name | The log forwarder lambda role name |
| log\_forwarder\_role\_policy\_arn | The ARN of the log forwarder lambda role policy |
| log\_forwarder\_role\_policy\_name | The name of the log forwarder lambda role policy |
| log\_forwarder\_s3\_bucket\_arn | The ARN of the log forwarder bucket. Will be of format arn:aws:s3:::bucketname |
| log\_forwarder\_s3\_bucket\_domain\_name | The log forwarder bucket domain name. Will be of format bucketname.s3.amazonaws.com |
| log\_forwarder\_s3\_bucket\_regional\_domain\_name | The log forwarder bucket region-specific domain name. The bucket domain name including the region name |
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
| rds\_em\_forwarder\_lambda\_qualified\_arn | The ARN of the RDS enhanced monitoring forwarder lambda function (if versioning is enabled via publish = true) |
| rds\_em\_forwarder\_lambda\_source\_code\_hash | Base64-encoded representation of raw SHA-256 sum of the RDS enhanced monitoring lambda forwarder zip file, provided either via filename or s3\_\* parameters |
| rds\_em\_forwarder\_role\_arn | The RDS enhanced monitoring forwarder lambda role arn |
| rds\_em\_forwarder\_role\_name | The RDS enhanced monitoring forwarder lambda role name |
| rds\_em\_forwarder\_role\_policy\_arn | The ARN of the RDS enhanced monitoring forwarder lambda role policy |
| rds\_em\_forwarder\_role\_policy\_name | The name of the RDS enhanced monitoring forwarder lambda role policy |
| traces\_endpoint\_arn | ARN of the traces VPC endpoint |
| traces\_endpoint\_dns\_entry | DNS entries of the traces VPC endpoint |
| traces\_endpoint\_id | ID of the traces VPC endpoint |
| traces\_endpoint\_network\_interface\_ids | One or more network interfaces for the traces VPC endpoint |
| traces\_endpoint\_owner\_id | The ID of the AWS account that owns the traces VPC endpoint |
| traces\_endpoint\_state | The state of the traces VPC endpoint |
| vpc\_fl\_forwarder\_cloudwatch\_log\_group\_arn | The ARN of the VPC flow log forwarder lambda function CloudWatch log group |
| vpc\_fl\_forwarder\_lambda\_arn | The ARN of the VPC flow log forwarder lambda function |
| vpc\_fl\_forwarder\_lambda\_qualified\_arn | The ARN of the VPC flow log forwarder lambda function (if versioning is enabled via publish = true) |
| vpc\_fl\_forwarder\_lambda\_source\_code\_hash | Base64-encoded representation of raw SHA-256 sum of the VPC flow log forwarder lambda zip file, provided either via filename or s3\_\* parameters |
| vpc\_fl\_forwarder\_role\_arn | The VPC flow log forwarder lambda role arn |
| vpc\_fl\_forwarder\_role\_name | The VPC flow log forwarder lambda role name |
| vpc\_fl\_forwarder\_role\_policy\_arn | The ARN of the VPC flow log forwarder lambda role policy |
| vpc\_fl\_forwarder\_role\_policy\_name | The name of the VPC flow log forwarder lambda role policy |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

Apache-2.0 Licensed. See [LICENSE](../../LICENSE).
