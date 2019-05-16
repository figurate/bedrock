#!/usr/bin/env bash
ENVIRONMENT=${1:-$TF_ENVIRONMENT}
ENV_SUFFIX=${2:-$TF_ENV_SUFFIX}
AWS_ACCOUNT=$(aws sts get-caller-identity | jq -r '.Account')
cat <<EOF
environment="$ENVIRONMENT"
env_suffix="$ENV_SUFFIX"
assume_role_account="$AWS_ACCOUNT"
EOF
