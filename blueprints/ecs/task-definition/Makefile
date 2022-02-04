SHELL:=/bin/bash
AWS_DEFAULT_REGION?=ap-southeast-2

TERRAFORM_VERSION=0.13.4
TERRAFORM=docker run --rm -v "${PWD}:/work" -v "${HOME}:/root" -e AWS_DEFAULT_REGION=$(AWS_DEFAULT_REGION) -e http_proxy=$(http_proxy) --net=host -w /work hashicorp/terraform:$(TERRAFORM_VERSION)

TERRAFORM_DOCS=docker run --rm -v "${PWD}:/work" tmknom/terraform-docs

CHECKOV=docker run --rm -v "${PWD}:/work" bridgecrew/checkov

TFSEC=docker run --rm -v "${PWD}:/work" liamg/tfsec

DIAGRAMS=docker run -v "${PWD}:/work" figurate/diagrams python

NAME=$(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

REGISTRY?=bedrock
TAGS?=latest
BUILD_ARGS?=

.PHONY: all build tag push

all: build

clean:
	docker rmi $(REGISTRY)/ecs-task-definition

build:
	 docker build -t $(REGISTRY)/ecs-task-definition ${BUILD_ARGS} --build-arg TERRAFORM_VERSION=$(TERRAFORM_VERSION) --build-arg HTTP_PROXY=${http_proxy} --network=host .

tag: build
	echo $(TAGS) | tr "/," "-\n" | xargs -n1 -I % docker tag $(REGISTRY)/ecs-task-definition $(REGISTRY)/ecs-task-definition:%

push: tag
	echo $(TAGS) | tr "/," "-\n" | xargs -n1 -I % docker push $(REGISTRY)/ecs-task-definition:%
