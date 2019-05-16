variable "codebuild_image" {
  description = "Docker image used to run build specs"
  default = "aws/codebuild/docker:17.09.0"
}

//variable "build_type" {
//  description = "Indicates the buildspec to use for the build job"
//  default = "blueprint"
//}

variable "build_timeout" {
  description = "Maximum build time in minutes"
  default = "5"
}

//variable "codecommit_repo" {
//  description = "The source repository for the codebuild specification"
//}

variable "blueprints_bucket" {
  description = "S3 bucket containing blueprint packages"
}

variable "buildspec" {
  description = "Build specification content"
  default = <<EOF
version 0.2

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
EOF
}

variable "aws_access_key" {
  description = "IAM access key used by codebuild to execute the blueprint"
}

variable "aws_secret_key" {
  description = "IAM secret access key used by codebuild to execute the blueprint"
}