#!/bin/bash

# get credentials from ~/.aws/config file; grab the first one
FILELINE=`grep -m 1 aws_access_key_id $HOME/.aws/config`
ACCESS_KEY=`cut -d ' ' -f3 <<< $FILELINE`

FILELINE=`grep -m 1 aws_secret_access_key $HOME/.aws/config`
SECRET_ACCESS_KEY=`cut -d ' ' -f3 <<< $FILELINE`

# set policy to run
THE_POLICY="/policies/ec2/enforce-ec2-tags.yaml"
THE_REGIONS='all'
THE_POLICY="/policies/s3/audit-s3-encrypted.yaml"
THE_REGIONS='us-east-1'

docker run --rm \
  -v $(pwd)/output:/home/custodian/output \
  -v $(pwd)$THE_POLICY:/home/custodian/policy.yaml \
  --env-file <(env | grep "^AWS\|^AZURE\|^GOOGLE") \
  -e AWS_ACCESS_KEY_ID=$ACCESS_KEY -e AWS_SECRET_ACCESS_KEY=$SECRET_ACCESS_KEY \
  -e AWS_DEFAULT_REGION=us-east-1 \
  cloudcustodian/c7n run --region $THE_REGIONS -v -s /home/custodian/output /home/custodian/policy.yaml

# if scanning only 1 region, you'll need to use keys
  # -e AWS_DEFAULT_REGION=us-east-1 \
  # -e AWS_ACCESS_KEY_ID=$ACCESS_KEY -e AWS_SECRET_ACCESS_KEY=$SECRET_ACCESS_KEY \

# or scan all regions with --region all keyword in the command line

# in theory, we should be able to pass in a profile name; doesn't work
  # -e AWS_PROFILE=mine \
