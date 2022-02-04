SHELL:=/bin/bash
AWS_DEFAULT_REGION?=ap-southeast-2

TERRAFORM_VERSION=1.0.0
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

all: test build

clean:
	docker rmi $(REGISTRY)/aws-ecr-repository

build:
	 docker build -t $(REGISTRY)/aws-ecr-repository ${BUILD_ARGS} --build-arg TERRAFORM_VERSION=$(TERRAFORM_VERSION) --build-arg HTTP_PROXY=${http_proxy} --network=host .

tag: build
	echo $(TAGS) | tr "/," "-\n" | xargs -n1 -I % docker tag $(REGISTRY)/aws-ecr-repository $(REGISTRY)/aws-ecr-repository:%

push: tag
	echo $(TAGS) | tr "/," "-\n" | xargs -n1 -I % docker push $(REGISTRY)/aws-ecr-repository:%

#.PHONY: all clean validate test docs format
#
#all: validate test docs format
#
#clean:
#	rm -rf .terraform/
#
validate:
	$(TERRAFORM) init -upgrade && $(TERRAFORM) validate

test: validate
	$(CHECKOV) -d /work

	$(TFSEC) /work

build:
	docker build ${BUILD_ARGS} --build-arg TERRAFORM_VERSION=$(TERRAFORM_VERSION) --build-arg HTTP_PROXY=${http_proxy} -t $(REGISTRY)/$@ --network=host $(subst -,/,$@)

docs: diagram
	$(TERRAFORM_DOCS) markdown ./ >./README.md

format:
	$(TERRAFORM) fmt -list=true ./
#
#new:
#	$(TERRAFORM) workspace new $(NAME) && $(TERRAFORM) init
#
#refresh:
#	$(TERRAFORM) init $(NAME) && $(TERRAFORM) apply
#
#destroy:
#	$(TERRAFORM) destroy $(NAME)

plan:
	$(TERRAFORM) plan -input=false

apply:
	$(TERRAFORM) apply -input=false
