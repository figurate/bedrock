#!/usr/bin/env bash
STACK=${1:-$TF_STACK}
ENVIRONMENT=${2:-$TF_ENVIRONMENT}
ENV_SUFFIX=${3:-$TF_ENV_SUFFIX}
cat <<EOF
environment="$ENVIRONMENT"
env_suffix="$ENV_SUFFIX"
stack_name="$STACK"
EOF
