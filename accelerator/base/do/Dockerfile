FROM hashicorp/terraform:light

RUN apk add --update jq python py-pip && pip install awscli

WORKDIR /work

ADD *.sh *.tf /bootstrap/

ENTRYPOINT ["/bin/sh"]

ENV AWS_DEFAULT_REGION="ap-southeast-2"

ENV TF_BACKEND_KEY="__UNDEFINED__"

CMD ["/bootstrap/run.sh"]