# Notes on running Cloud-Custodian from Docker Hub
## Launching container
    $ docker pull cloudcustodian/c7n
    $ docker images  # should see cloudcustodian/c7n
    $ docker run -it \
      -v $(pwd)/output:/home/custodian/output \
      -v $(pwd)/policy.yml:/home/custodian/policy.yml \
      --env-file <(env | grep "^AWS\|^AZURE\|^GOOGLE") \
        cloudcustodian/c7n run -v -s /home/custodian/output /home/custodian/policy.yml

###
https://cloudcustodian.io/docs/

https://cloudcustodian.io/docs/quickstart/index.html