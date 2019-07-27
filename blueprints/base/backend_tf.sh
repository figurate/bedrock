#!/usr/bin/env bash
ACCOUNT_ID=$(aws sts get-caller-identity | jq -r '.Account')
TF_STATE_BUCKET=${1:-$ACCOUNT_ID-terraform-state}
cat <<EOF
terraform {
  backend "s3" {
    bucket = "${TF_STATE_BUCKET}"
    dynamodb_table = "terraform-lock"
  }
}
EOF
