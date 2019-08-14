#!/usr/bin/env bash

function usage() {
  cat << EOF

USAGE: $0 <init|plan|apply|destroy|import|taint|output|export>
EOF
}

# Initialise terraform provider, etc.
function init() {
  echo "Initialising terraform state.."
	terraform init -backend-config backend.tfvars $TF_ARGS /bootstrap &
	tf_process=$!
  wait "$tf_process"
}

# Show resources to be provisioned
function plan() {
	terraform plan $TF_ARGS /bootstrap &
	tf_process=$!
  wait "$tf_process"
}

# Provision resources
function apply() {
	terraform apply $TF_ARGS /bootstrap &
	tf_process=$!
  wait "$tf_process"

	# Additional commands to run after terraform apply
#	/bootstrap/post-apply.sh "$@"
}

# Remove resources
function destroy() {
	terraform destroy $TF_ARGS /bootstrap &
	tf_process=$!
  wait "$tf_process"
}

# Import existing resources
function import() {
	terraform import -config=/bootstrap $TF_ARGS "$@" &
	tf_process=$!
  wait "$tf_process"
}

# Taint existing state
function taint() {
	terraform taint $TF_ARGS "$@" &
	tf_process=$!
  wait "$tf_process"
}

# Print outputs
function output() {
	terraform output $TF_ARGS &
	tf_process=$!
  wait "$tf_process"
}

# Unlock state
function force-unlock() {
	terraform force-unlock $TF_ARGS "$@" /bootstrap &
	tf_process=$!
  wait "$tf_process"
}

# export terraform scripts to current working directory
function export_tf() {
  echo "Exporting terraform scripts.."
	bash /bootstrap/export.sh
}

_term() {
  echo "Caught SIGTERM signal!"
  kill -TERM "$tf_process" 2>/dev/null
}

trap _term SIGTERM

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
	export) 		    export_tf;;
	*)				      usage;;
esac
