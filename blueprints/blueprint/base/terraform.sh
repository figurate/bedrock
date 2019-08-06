#!/usr/bin/env bash

function usage() {
  cat << EOF

USAGE: $0 <init|plan|apply|destroy|import|taint|output|export>
EOF
}

# Initialise terraform provider, etc.
function init() {
	terraform init -backend-config backend.tfvars $TF_ARGS /bootstrap
}

# Show resources to be provisioned
function plan() {
	terraform plan $TF_ARGS /bootstrap
}

# Provision resources
function apply() {
	terraform apply $TF_ARGS /bootstrap

	# Additional commands to run after terraform apply
	/bootstrap/post-apply.sh "$@"
}

# Remove resources
function destroy() {
	terraform destroy $TF_ARGS /bootstrap
}

# Import existing resources
function import() {
	terraform import -config=/bootstrap $TF_ARGS "$@"
}

# Taint existing state
function taint() {
	terraform taint $TF_ARGS "$@"
}

# Print outputs
function output() {
	terraform output $TF_ARGS
}

# Unlock state
function force-unlock() {
	terraform force-unlock $TF_ARGS "$@" /bootstrap
}

# export terraform scripts to current working directory
function export() {
	bash /bootstrap/export.sh
}

# Generate terraform backend config
sh /bootstrap/backend_tf.sh $TF_STATE_BUCKET > /bootstrap/backend.tf
sh /bootstrap/backend_tfvars.sh $TF_BACKEND_KEY > backend.tfvars

TF_ACTION=${1:-init}

TF_VAR_assume_role_account=$(aws sts get-caller-identity | jq -r '.Account')
export TF_VAR_assume_role_account

case "$TF_ACTION" in
	init) 			    init;;
	plan) 			    plan;;
	apply) 			    apply "${@:2}";;
	destroy) 		    destroy;;
	import) 		    import "${@:2}";;
	taint) 			    taint "${@:2}";;
	output) 		    output;;
	force-unlock)   force-unlock "${@:2}";;
	export) 		    export;;
	*)				      usage;;
esac
