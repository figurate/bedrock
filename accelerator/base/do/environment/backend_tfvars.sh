#!/usr/bin/env bash
BACKEND_KEY=${TF_BACKEND_KEY:-$(basename $PWD)}
ENVIRONMENT=${1:-$TF_ENVIRONMENT}
ENV_SUFFIX=${2:-$TF_ENV_SUFFIX}
SEPARATOR=$([ -n "$ENV_SUFFIX" ] && echo "-" || echo "")
cat <<EOF
key="$BACKEND_KEY/${ENVIRONMENT//"/"/-}$SEPARATOR${ENV_SUFFIX//"/"/-}/terraform.tfstate"
EOF
