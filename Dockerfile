FROM ubuntu

ADD scripts/ubuntu/bootstrap-docker.sh /root/

RUN cd /root && bash ./bootstrap-docker.sh

ENTRYPOINT /bin/bash
