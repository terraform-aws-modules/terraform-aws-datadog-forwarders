#!/usr/bin/env bash

cd $(dirname $0)

BASE_URL='https://raw.githubusercontent.com/DataDog/datadog-serverless-functions'
REFS_URL='https://api.github.com/repos/DataDog/datadog-serverless-functions/git/refs/tags'

for VERSION in $(curl $REFS_URL | jq '.[].ref' | grep -o '3\.[0-9]*\.[0-9]')
do
  rds_enhanced_monitoring="${BASE_URL}/aws-dd-forwarder-${VERSION}/aws/rds_enhanced_monitoring/lambda_function.py"
  vpc_flow_log_monitoring="${BASE_URL}/aws-dd-forwarder-${VERSION}/aws/vpc_flow_log_monitoring/lambda_function.py"
  lambda_file='lambda_function.py'

  rds_archive="modules/rds_enhanced_monitoring_forwarder/vendored_archives/${VERSION}.zip"

  if [ ! -f $rds_archive ]; then
    echo $rds_archive
    curl --silent -o $lambda_file -L $rds_enhanced_monitoring
    zip -q $rds_archive $lambda_file
    rm $lambda_file
  fi

  vpc_archive="modules/vpc_flow_log_forwarder/vendored_archives/${VERSION}.zip"

  if [ ! -f $vpc_archive ]; then
    curl --silent -o $lambda_file -L $vpc_flow_log_monitoring
    zip -q $vpc_archive $lambda_file
    rm $lambda_file
  fi

done
