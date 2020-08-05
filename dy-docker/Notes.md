# Notes on running Cloud-Custodian from Docker Hub
## Launching container
    $ docker pull cloudcustodian/c7n
    $ docker images  # should see cloudcustodian/c7n
    $ docker run -it \
      -v $(pwd)/output:/home/custodian/output \
      -v $(pwd)/policy.yml:/home/custodian/policy.yml \
      --env-file <(env | grep "^AWS\|^AZURE\|^GOOGLE") \
      cloudcustodian/c7n run -v -s /home/custodian/output /home/custodian/policy.yml

where 
>-i is Keep STDIN open even if not attached (--interactive)<br>
>-t is Allocate a pseudo-TTY (--tty)<br>
>-v is Bind mount a volume (--volume)<br>
>--env-file Read in a file of environment variables<br>
>c7n -v is verbose (--verbose)<br>
>c7n -s is output dir (--output-dir)<br>

###
https://cloudcustodian.io/docs/

https://cloudcustodian.io/docs/quickstart/index.html