#!/usr/bin/env bash
ENVIRONMENT=${1:-$TF_ENVIRONMENT}
ENV_SUFFIX=${2:-$TF_ENV_SUFFIX}
cat <<EOF
environment="$ENVIRONMENT"
env_suffix="$ENV_SUFFIX"
EOF
