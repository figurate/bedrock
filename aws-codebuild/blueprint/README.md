# AWS Codebuild configuration

Provision a codebuild with the following features:

 - Dedicated user with limited permissions
 - Build parameters stored in SSM Parameter Store
 - KMS encryption of sensitive build parameters
 - Configurable build container


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assume\_role\_account | AWS account ID for the role to assume into | string | - | yes |
| aws\_access\_key | IAM access key used by codebuild to execute the blueprint | string | - | yes |
| aws\_secret\_key | IAM secret access key used by codebuild to execute the blueprint | string | - | yes |
| blueprints\_bucket | S3 bucket containing blueprint packages | string | - | yes |
| build\_timeout | Maximum build time in minutes | string | `5` | no |
| buildspec | Build specification content | string | `version 0.2

phases:
  build:
    commands:
      - docker run --privileged -it --rm \
  --mount type=bind,source="$(pwd)",target=/work \
  -e TF_BACKEND_KEY=$BLUEPRINT/\${TF_BACKEND_KEY:-$(basename $PWD)} \
  -e TF_APPLY_ARGS="\${TF_APPLY_ARGS}" \
  -e AWS_PROFILE=\${AWS_PROFILE-iamadmin} \
  -e TF_VAR_region=\${AWS_DEFAULT_REGION} \
  -e http_proxy=\${http_proxy:-} \
  -e https_proxy=\${https_proxy:-} \
  -e no_proxy=\${no_proxy:-} \
  --net=host \
  bedrock/$BLUEPRINT $@
` | no |
| codebuild\_image | Docker image used to run build specs | string | `aws/codebuild/docker:17.09.0` | no |
| region | AWS default region | string | - | yes |

