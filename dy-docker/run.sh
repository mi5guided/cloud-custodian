#!/bin/bash

# get credentials from ~/.aws/config file; grab the first one
FILELINE=`grep -m 1 aws_access_key_id $HOME/.aws/config`
ACCESS_KEY=`cut -d ' ' -f3 <<< $FILELINE`

FILELINE=`grep -m 1 aws_secret_access_key $HOME/.aws/config`
SECRET_ACCESS_KEY=`cut -d ' ' -f3 <<< $FILELINE`

docker run --rm \
  -v $(pwd)/output:/home/custodian/output \
  -v $(pwd)/policy.yml:/home/custodian/policy.yml \
  --env-file <(env | grep "^AWS\|^AZURE\|^GOOGLE") \
  -e AWS_ACCESS_KEY_ID=$ACCESS_KEY -e AWS_SECRET_ACCESS_KEY=$SECRET_ACCESS_KEY \
  -e AWS_DEFAULT_REGION=us-east-1 \
  cloudcustodian/c7n report --region all -v -s /home/custodian/output /home/custodian/policy.yml

# if scanning only 1 region, you'll need to use keys
  # -e AWS_DEFAULT_REGION=us-east-1 \
  # -e AWS_ACCESS_KEY_ID=$ACCESS_KEY -e AWS_SECRET_ACCESS_KEY=$SECRET_ACCESS_KEY \

# or scan all regions with --region all keyword in the command line

# in theory, we should be able to pass in a profile name; doesn't work
  # -e AWS_PROFILE=mine \
