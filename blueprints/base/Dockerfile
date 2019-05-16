FROM hashicorp/terraform:light

MAINTAINER Ben Fortuna

ARG HTTP_PROXY=""

RUN http_proxy=${HTTP_PROXY} apk add --update jq python py-pip bash groff \
    && pip --no-cache-dir install awscli

WORKDIR /work

ADD *.sh /bootstrap/
ADD environment /bootstrap/environment
ADD stack /bootstrap/stack

ENTRYPOINT ["/bootstrap/terraform.sh"]

# aws cli help doesn't work with busybox less
ENV PAGER="cat"

ENV AWS_DEFAULT_REGION="ap-southeast-2"

ENV TF_BACKEND_KEY="__UNDEFINED__"

CMD [""]