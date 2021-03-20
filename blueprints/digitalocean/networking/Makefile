SHELL:=/bin/bash
TF_WORKSPACE?=micronode

ifneq (, $(shell which docker))
TERRAFORM_VERSION=0.14.7
TERRAFORM=docker run --rm -v "${PWD}:/work" -v "${HOME}/.ssh:/root/.ssh" -v "${HOME}/.aws:/root/.aws" -v "${HOME}/.terraformrc:/root/.terraformrc" -e AWS_DEFAULT_REGION=$(AWS_DEFAULT_REGION) -e http_proxy=$(http_proxy) --net=host -w /work hashicorp/terraform:$(TERRAFORM_VERSION)
else
TERRAFORM=terraform
endif

TERRAFORM_DOCS=docker run --rm -v "${PWD}:/work" tmknom/terraform-docs

CHECKOV=docker run --rm -v "${PWD}:/work" bridgecrew/checkov

TFSEC=docker run --rm -v "${PWD}:/work" liamg/tfsec

DIAGRAMS=docker run -v "${PWD}:/work" figurate/diagrams python

.PHONY: all clean init validate test docs format list new select plan apply

WORKSPACE=$(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))

all: test docs format

clean:
	rm -rf .terraform/

init:
	$(TERRAFORM) init -upgrade

validate: init
	$(TERRAFORM) validate

test: validate
	$(CHECKOV) -d /work

	$(TFSEC) /work

diagram:
	$(DIAGRAMS) diagram.py

docs: diagram
	$(TERRAFORM_DOCS) markdown ./ >./README.md

format:
	$(TERRAFORM) fmt -list=true ./

list:
	$(TERRAFORM) workspace list

new:
	$(TERRAFORM) workspace new $(WORKSPACE)

select:
	$(TERRAFORM) workspace select $(WORKSPACE)

workspace:
	$(TERRAFORM) workspace show

plan:
	$(TERRAFORM) plan -input=false -var-file=$(TF_WORKSPACE).tfvars

apply:
	$(TERRAFORM) apply -input=false -var-file=$(TF_WORKSPACE).tfvars $(TF_ARGS)