FROM ubuntu

ADD orchestration/scripts/ubuntu/bootstrap-docker.sh /root/

RUN apt-get update && apt-get install -y curl git python3-pip apt-transport-https \
     ca-certificates software-properties-common corkscrew unzip wget ssh jq ruby vim

RUN cd /root && bash ./bootstrap-docker.sh

WORKDIR /work

ENTRYPOINT /bin/bash
