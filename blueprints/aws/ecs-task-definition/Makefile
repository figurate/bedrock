SHELL:=/bin/bash
AWS_DEFAULT_REGION?=ap-southeast-2

TERRAFORM_VERSION=0.13.4
TERRAFORM=docker run --rm -v "${PWD}:/work" -v "${HOME}:/root" -e AWS_DEFAULT_REGION=$(AWS_DEFAULT_REGION) -e http_proxy=$(http_proxy) --net=host -w /work hashicorp/terraform:$(TERRAFORM_VERSION)

TERRAFORM_DOCS=docker run --rm -v "${PWD}:/work" tmknom/terraform-docs

CHECKOV=docker run --rm -v "${PWD}:/work" bridgecrew/checkov

TFSEC=docker run --rm -v "${PWD}:/work" liamg/tfsec

DIAGRAMS=docker run -v "${PWD}:/work" figurate/diagrams python

NAME=$(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

DOCKER_REGISTRY?=bedrock
DOCKER_IMAGE?=aws-`basename $(PWD)`
DOCKER_TAGS?=latest
BUILD_ARGS?=

.PHONY: all build tag push

all: build

clean:
	docker rmi $(DOCKER_REGISTRY)/$(DOCKER_IMAGE)

build:
	 docker build -t $(DOCKER_REGISTRY)/$(DOCKER_IMAGE) ${BUILD_ARGS} --build-arg TERRAFORM_VERSION=$(TERRAFORM_VERSION) --build-arg HTTP_PROXY=${http_proxy} --network=host .

tag:
	echo $(DOCKER_TAGS) | tr "/," "-\n" | xargs -n1 -I % docker tag $(DOCKER_REGISTRY)/$(DOCKER_IMAGE) $(DOCKER_REGISTRY)/$(DOCKER_IMAGE):%

push:
	echo $(DOCKER_TAGS) | tr "/," "-\n" | xargs -n1 -I % docker push $(DOCKER_REGISTRY)/$(DOCKER_IMAGE):%
