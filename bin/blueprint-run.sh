#!/usr/bin/env bash
BEDROCK_BLUEPRINT=${BEDROCK_BLUEPRINT:-$(basename $0 .sh)}
BEDROCK_REGISTRY=${BEDROCK_REGISTRY:-bedrock}

docker run --privileged -it --rm \
  --mount type=bind,source="$(pwd)",target=/work \
  --volume "$HOME/.aws:/root/.aws" \
  --volume "$HOME/.ssh:/root/.ssh" \
  -e TF_BACKEND_KEY=$BEDROCK_BLUEPRINT/${TF_BACKEND_KEY:-$(basename $PWD)} \
  -e TF_APPLY_ARGS="${TF_APPLY_ARGS}" \
  -e AWS_PROFILE=${AWS_PROFILE-iamadmin} \
  -e TF_VAR_region=${AWS_DEFAULT_REGION} \
  -e http_proxy=${http_proxy:-} \
  -e https_proxy=${https_proxy:-} \
  -e no_proxy=${no_proxy:-} \
  --net=host \
  $BEDROCK_REGISTRY/$BEDROCK_BLUEPRINT $@