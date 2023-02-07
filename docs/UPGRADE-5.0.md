# Upgrade from v4.x to v5.x

## Terraform State Moves
The following Terraform state move commands are optional but recommended, if you want to avoid recreating the used S3 bucket.
Because the resource `aws_s3_bucket_object` is deprecated and replaced by `aws_s3_bucket` with this release.

The associated state move command would look similar to (albeit with your correct module name):

```sh
terraform state mv 'module.datadog_log_forwarder.aws_s3_bucket_object.this[0]' 'module.datadog_log_forwarder.aws_s3_object.this[0]'
```
