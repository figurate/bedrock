#!/usr/bin/env bash
set +x

unset AWS_SECRET_ACCESS_KEY
unset AWS_ACCESS_KEY_ID
unset AWS_SESSION_TOKEN

ROLE="${1:-}"
DEFAULT_ACCOUNT="$(aws sts get-caller-identity | jq -r '.Account')"
ACCOUNT="${2:-$DEFAULT_ACCOUNT}"
DURATION="${3:-900}"

result=$(aws sts assume-role --role-arn "arn:aws:iam::${ACCOUNT}:role/${ROLE}" --role-session-name "${ROLE}-${ACCOUNT}-assume-role-session" --duration-seconds "${DURATION}" --query 'Credentials.[SecretAccessKey,AccessKeyId,SessionToken]' --output text)

export AWS_SECRET_ACCESS_KEY=$(echo ${result} | cut -f1 -d ' ')
export AWS_ACCESS_KEY_ID=$(echo ${result} | cut -f2 -d ' ')
export AWS_SESSION_TOKEN=$(echo ${result} | cut -f3 -d ' ')
