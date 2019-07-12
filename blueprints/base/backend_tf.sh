#!/usr/bin/env bash
ACCOUNT_ID=$(aws sts get-caller-identity | jq -r '.Account')
TF_STATE_BUCKET=${1:-$ACCOUNT_ID-bedrock-state}
cat <<EOF
terraform {
  backend "s3" {
    bucket = "${TF_STATE_BUCKET}"
  }
}
EOF
