#!/bin/bash

docker run -it \
  -v $(pwd)/output:/home/custodian/output \
  -v $(pwd)/policy.yml:/home/custodian/policy.yml \
  --env-file <(env | grep "^AWS\|^AZURE\|^GOOGLE") \
     cloudcustodian/c7n run -v -s /home/custodian/output /home/custodian/policy.yml