SHELL:=/bin/bash
TERRAFORM_IMAGE=bedrock/tfe-organization
TERRAFORM_VERSION=latest
TERRAFORM=docker run --rm -v "${PWD}:/work" -v "${HOME}:/root" -e AWS_DEFAULT_REGION=$(AWS_DEFAULT_REGION) -e http_proxy=$(http_proxy) --net=host -w /work $(TERRAFORM_IMAGE):$(TERRAFORM_VERSION)

.PHONY: all clean test docs format list new select plan

all: test docs format

clean:
	rm -rf .terraform/

init:
	$(TERRAFORM) init -upgrade=true -backend-config=backend.tfvars

test: init
	$(TERRAFORM) validate

docs:
	docker run --rm -v "${PWD}:/work" tmknom/terraform-docs markdown ./ >./README.md

format:
	$(TERRAFORM) fmt -list=true ./

list:
	$(TERRAFORM) workspace list

new:
	$(TERRAFORM) workspace new $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

select:
	$(TERRAFORM) workspace select $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

workspace:
	$(TERRAFORM) workspace show

plan: init
	$(TERRAFORM) plan -input=false

apply: init
	$(TERRAFORM) apply -input=false $(TF_ARGS)