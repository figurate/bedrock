SHELL:=/bin/bash
AWS_DEFAULT_REGION?=ap-southeast-2

TERRAFORM_IMAGE=hashicorp/terraform
TERRAFORM_VERSION=0.13.4
TERRAFORM=docker run --rm -v "${PWD}:/work" -v "${HOME}:/root" -e AWS_DEFAULT_REGION=$(AWS_DEFAULT_REGION) -e http_proxy=$(http_proxy) --net=host -w /work $(TERRAFORM_IMAGE):$(TERRAFORM_VERSION)

TERRAFORM_DOCS=docker run --rm -v "${PWD}:/work" tmknom/terraform-docs

CHECKOV=docker run -t -v "${PWD}:/work" bridgecrew/checkov

DIAGRAMS=docker run -t -v "${PWD}:/work" figurate/diagrams python

OPA=docker run -t -v "${PWD}:/work" openpolicyagent/opa eval --format pretty

.PHONY: all clean validate test docs format list new select plan

all: validate test docs format

clean:
	rm -rf .terraform/

init:
	$(TERRAFORM) init -upgrade=true --backend-config=backend.tfvars

validate: init
	$(TERRAFORM) validate

test: validate
	$(CHECKOV) -d /work

diagram:
	$(DIAGRAMS) diagram.py

docs: diagram
	$(TERRAFORM_DOCS) markdown ./ >./README.md && \
		$(TERRAFORM_DOCS) markdown ./modules/dns > ./modules/dns/README.md

format:
	$(TERRAFORM) fmt -list=true ./ && \
		$(TERRAFORM) fmt -list=true ./modules/dns

list:
	$(TERRAFORM) workspace list

new:
	$(TERRAFORM) workspace new $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

select:
	$(TERRAFORM) workspace select $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

workspace:
	$(TERRAFORM) workspace show

plan:
	$(TERRAFORM) plan -input=false

verify:
	$(TERRAFORM) show --json plan.binary > plan.json
	$(OPA) --data /work/plan.rego --input /work/plan.json data.ecs.service.verify

apply:
	$(TERRAFORM) apply -input=false $(TF_ARGS)

upgrade:
	$(TERRAFORM) 0.13upgrade -yes .terraform/modules/$(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))
