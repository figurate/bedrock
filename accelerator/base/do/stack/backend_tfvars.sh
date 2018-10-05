#!/usr/bin/env bash
BACKEND_KEY=${TF_BACKEND_KEY:-$(basename $PWD)}
STACK=${1:-$TF_STACK}
ENVIRONMENT=${2:-$TF_ENVIRONMENT}
ENV_SUFFIX=${3:-$TF_ENV_SUFFIX}
SEPARATOR=$([ -n "$ENV_SUFFIX" ] && echo "-" || echo "")
cat <<EOF
key="$BACKEND_KEY/${STACK//"/"/-}/${ENVIRONMENT//"/"/-}$SEPARATOR${ENV_SUFFIX//"/"/-}/terraform.tfstate"
EOF
