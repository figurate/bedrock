FROM hashicorp/terraform:light

RUN apk add --update jq python py-pip && pip install awscli

WORKDIR /work

ADD *.sh *.tf /bootstrap/

ENTRYPOINT ["/bin/sh"]

ENV AWS_DEFAULT_REGION="ap-southeast-2"

ENV TF_BACKEND_KEY="__UNDEFINED__"

#ENV AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY

CMD ["/bootstrap/run.sh"]