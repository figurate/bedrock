#!/usr/bin/env bash
AWS_ACCOUNT=$(aws sts get-caller-identity | jq -r '.Account')
cat <<EOF
assume_role_account="$AWS_ACCOUNT"
EOF
