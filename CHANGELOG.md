# Changelog

All notable changes to this project will be documented in this file.

## [7.0.0](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/compare/v6.2.0...v7.0.0) (2025-07-27)


### ⚠ BREAKING CHANGES

* Upgrade AWS provider and min required Terraform version to `6.0` and `1.5.7` respectively (#53)

### Features

* Upgrade AWS provider and min required Terraform version to `6.0` and `1.5.7` respectively ([#53](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/issues/53)) ([7cbb68f](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/commit/7cbb68fed208c817996b8307b54d9d992992f655))

## [6.2.0](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/compare/v6.1.0...v6.2.0) (2024-11-11)


### Features

* Vendor latest versions and set default version to `v3.130.0` ([#47](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/issues/47)) ([8c8d16e](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/commit/8c8d16eccaf62ddc432fd4d8f407599b1a658eb1))


### Bug Fixes

* Update CI workflow versions to latest ([#46](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/issues/46)) ([9db882b](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/commit/9db882bfb87b9a58ac8d830cda0a22101f4bd362))

## [6.1.0](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/compare/v6.0.2...v6.1.0) (2024-08-28)


### Features

* Add variable for applying tags to the log_forwarder bucket ([#41](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/issues/41)) ([37701a0](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/commit/37701a060872da245fd35117e0fcb88065f24d36))

## [6.0.2](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/compare/v6.0.1...v6.0.2) (2024-03-07)


### Bug Fixes

* Update CI workflow versions to remove deprecated runtime warnings ([#38](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/issues/38)) ([8448b57](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/commit/8448b57d88a59a9ee69dd80342c2600bb2add177))

### [6.0.1](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/compare/v6.0.0...v6.0.1) (2024-02-23)


### Bug Fixes

* Change default runtime to python3.11 to support latest forwarder version ([#37](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/issues/37)) ([35805f8](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/commit/35805f851a91312a6a91ded0e93f7b96d6dc732b))

## [6.0.0](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/compare/v5.1.0...v6.0.0) (2024-02-22)


### ⚠ BREAKING CHANGES

* Bump Terraform and AWS provider MSV to `1.3` and `5.0` respectively, add latest releases and set `3.103.0` as the default version (#36)

### Features

* Bump Terraform and AWS provider MSV to `1.3` and `5.0` respectively, add latest releases and set `3.103.0` as the default version ([#36](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/issues/36)) ([588fbe9](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/commit/588fbe98741f1e17089f0064d0182d252158d1bf))

## [5.1.0](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/compare/v5.0.1...v5.1.0) (2023-04-21)


### Features

* Add support for CloudWatch log group KMS key ([#31](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/issues/31)) ([63e0576](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/commit/63e0576fdf682caf72a49f20f2d8a62d23445ebb))

### [5.0.1](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/compare/v5.0.0...v5.0.1) (2023-02-07)


### Bug Fixes

* Change tags for 'aws_s3_bucket_object' based on AWS limit and add validation for them ([#26](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/issues/26)) ([8250b8e](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/commit/8250b8e331fa6d730370d6f8fc243634000e16b7))

## [5.0.0](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/compare/v4.1.1...v5.0.0) (2023-02-03)


### ⚠ BREAKING CHANGES

* Update S3 module to v3.6.1 and switch to resource aws_s3_object (#29)

### Features

* Update S3 module to v3.6.1 and switch to resource aws_s3_object ([#29](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/issues/29)) ([11ff8e9](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/commit/11ff8e9dcd96aefb31a0998a8833b2c98e11b4f0))

### [4.1.1](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/compare/v4.1.0...v4.1.1) (2022-11-07)


### Bug Fixes

* Update CI configuration files to use latest version ([#23](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/issues/23)) ([24bbfe7](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders/commit/24bbfe7cc270db7c1bd82e015895f7c4eef11237))

## [4.1.0](https://github.com/clowdhaus/terraform-aws-datadog-forwarders/compare/v4.0.1...v4.1.0) (2022-04-20)


### Features

* Repo has moved to [terraform-aws-modules](https://github.com/terraform-aws-modules/terraform-aws-datadog-forwarders) organization ([420b921](https://github.com/clowdhaus/terraform-aws-datadog-forwarders/commit/420b9214b8684d6f9602533515ecc8b829d3244e))
