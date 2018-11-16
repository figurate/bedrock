#!/usr/bin/env bash
OIFS=$IFS;
IFS=",";
USERS=($TF_VAR_users)
USER_GROUPS=($TF_VAR_groups)
IFS=$OIFS;

echo "region = \"$TF_VAR_region\"
users = [$(printf "\"%s\"," "${USERS[@]}")]
groups = [$(printf "\"%s\"," "${USER_GROUPS[@]}")]
" > config.auto.tfvars