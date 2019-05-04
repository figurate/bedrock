#!/usr/bin/env bash
BLUEPRINT="$(basename $0 .sh)"

docker run --privileged -it --rm \
  --mount type=bind,source="$(pwd)",target=/work \
  --volume "$HOME/.aws:/root/.aws" \
  -e TF_BACKEND_KEY=$BLUEPRINT/$(basename $PWD) \
  -e AWS_PROFILE=${AWS_PROFILE-default} \
  -e TF_VAR_region=${AWS_DEFAULT_REGION} \
  bedrock/$BLUEPRINT $@