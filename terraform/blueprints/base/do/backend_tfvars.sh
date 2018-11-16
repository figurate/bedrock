#!/usr/bin/env bash
BACKEND_KEY=${1:-$TF_BACKEND_KEY}
cat <<EOF
key="$BACKEND_KEY/terraform.tfstate"
EOF
