ARG TERRAFORM_VERSION=latest
FROM hashicorp/terraform:${TERRAFORM_VERSION}

MAINTAINER Ben Fortuna

ARG HTTP_PROXY=""

COPY requirements.txt /tmp
RUN http_proxy=${HTTP_PROXY} apk add --update jq python py-pip bash groff \
    && https_proxy=${HTTP_PROXY} pip --no-cache-dir install -r /tmp/requirements.txt

RUN adduser -S bedrock && mkdir /work /bootstrap && chown bedrock /work /bootstrap
WORKDIR /work
USER bedrock

ADD *.sh /bootstrap/
ADD environment /bootstrap/environment
ADD stack /bootstrap/stack

ENTRYPOINT ["/bootstrap/terraform.sh"]

# aws cli help doesn't work with busybox less
ENV PAGER="cat"

ENV AWS_DEFAULT_REGION="ap-southeast-2"

ENV TF_BACKEND_KEY="__UNDEFINED__"

CMD [""]