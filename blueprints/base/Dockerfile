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

ENTRYPOINT ["/bootstrap/terraform.sh"]

# aws cli help doesn't work with busybox less
ENV PAGER="cat"

# Required environment variables..
ENV AWS_DEFAULT_REGION=""
ENV TF_VAR_region="$AWS_DEFAULT_REGION"
ENV TF_VAR_assume_role_account=""
ENV TF_BACKEND_KEY="__UNDEFINED__"

CMD [""]