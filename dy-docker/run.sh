#!/bin/bash

# get credentials from ~/.aws/config file
FILELINE=`cat $HOME/.aws/config | grep aws_access_key_id`
ACCESS_KEY=`cut -d ' ' -f3 <<< $FILELINE`

FILELINE=`cat $HOME/.aws/config | grep aws_secret_access_key`
SECRET_ACCESS_KEY=`cut -d ' ' -f3 <<< $FILELINE`


docker run -it \
  -v $(pwd)/output:/home/custodian/output \
  -v $(pwd)/policy.yml:/home/custodian/policy.yml \
  --env-file <(env | grep "^AWS\|^AZURE\|^GOOGLE") \
  -e AWS_ACCESS_KEY_ID=$ACCESS_KEY -e AWS_SECRET_ACCESS_KEY=$SECRET_ACCESS_KEY \
  -e AWS_DEFAULT_REGION=us-east-1 \
  cloudcustodian/c7n run -v -s /home/custodian/output /home/custodian/policy.yml
