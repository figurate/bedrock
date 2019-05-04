#!/usr/bin/env bash
STACK=${1:-$TF_STACK}
ENVIRONMENT=${2:-$TF_ENVIRONMENT}
ENV_SUFFIX=${3:-$TF_ENV_SUFFIX}
AWS_ACCOUNT=$(aws sts get-caller-identity | jq -r '.Account')
cat <<EOF
environment="$ENVIRONMENT"
env_suffix="$ENV_SUFFIX"
stack_name="$STACK"
assume_role_account="$AWS_ACCOUNT"
EOF
