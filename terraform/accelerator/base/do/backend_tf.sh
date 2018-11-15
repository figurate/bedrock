#!/usr/bin/env bash
cat <<EOF
terraform {
  backend "s3" {
    bucket = "$(aws sts get-caller-identity | jq -r '.Account')-terraform-state"
  }
}
EOF
