FROM hashicorp/terraform:light

MAINTAINER Ben Fortuna

RUN apk add --update jq python py-pip bash groff && pip install awscli

WORKDIR /work

ADD *.sh *.tf /bootstrap/

ENTRYPOINT []

# aws cli help doesn't work with busybox less
ENV PAGER="cat"

ENV TF_BACKEND_KEY="__UNDEFINED__"

CMD ["/bootstrap/apply.sh"]