#!/usr/bin/env bash

function usage() {
  cat << EOF

USAGE: $0 <init|plan|apply|destroy|import|taint|output|export>
EOF
}

# Initialise terraform provider, etc.
function init() {
	terraform init -backend-config backend.tfvars $TF_INIT_ARGS /bootstrap
}

# Show resources to be provisioned
function plan() {
	terraform plan /bootstrap
}

# Provision resources
function apply() {
	terraform apply $TF_APPLY_ARGS /bootstrap

	# Additional commands to run after terraform apply
	/bootstrap/post-apply.sh $@
}

# Remove resources
function destroy() {
	terraform destroy $TF_DESTROY_ARGS /bootstrap
}

# Import existing resources
function import() {
	terraform import -config=/bootstrap $@
}

# Taint existing state
function taint() {
	terraform taint $@
}

# Print outputs
function output() {
	terraform output
}

# export terraform scripts to current working directory
function export() {
	bash /bootstrap/export.sh
}

# Generate terraform backend config
sh /bootstrap/backend_tf.sh > /bootstrap/backend.tf

if [ -n "$TF_STACK" ]; then
    sh /bootstrap/stack/backend_tfvars.sh $TF_STACK $TF_ENVIRONMENT > backend.tfvars
    sh /bootstrap/stack/terraform_tfvars.sh $TF_STACK > terraform.tfvars
elif [ -n "$TF_ENVIRONMENT" ]; then
    sh /bootstrap/environment/backend_tfvars.sh $TF_ENVIRONMENT > backend.tfvars
    sh /bootstrap/environment/terraform_tfvars.sh $TF_ENVIRONMENT > terraform.tfvars
else
    sh /bootstrap/backend_tfvars.sh $TF_BACKEND_KEY > backend.tfvars
fi

TF_ACTION=${1:-init}

TF_VAR_assume_role_account=$(aws sts get-caller-identity | jq -r '.Account')

case "$TF_ACTION" in
	init) 			init;;
	plan) 			plan;;
	apply) 			apply;;
	destroy) 		destroy;;
	import) 		import ${@:2};;
	taint) 			taint ${@:2};;
	output) 		output;;
	export) 		export;;
	*)				usage;;
esac