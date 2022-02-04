/**
 * # AWS Codebuild configuration
 *
 * Provision a codebuild with the following features:
 *
 *  - Dedicated user with limited permissions
 *  - Build parameters stored in SSM Parameter Store
 *  - KMS encryption of sensitive build parameters
 *  - Configurable build container
 *
 */
data "aws_caller_identity" "current" {}

resource "aws_iam_user" "build_user" {
  name = "terraform-build"
  tags {
    Consumer = "codebuild"
  }
}

resource "aws_iam_access_key" "build_user" {
  user = "${aws_iam_user.build_user.name}"
}

resource "aws_kms_key" "build_params" {
  description = "Encryption key for sensitive build parameters"
  enable_key_rotation = true
  tags {
    Consumer = "codebuild"
  }
}

resource "aws_kms_alias" "build_params" {
  target_key_id = "${aws_kms_key.build_params.id}"
  name = "alias/terraform-build-params"
}

resource "aws_codecommit_repository" "build_repo" {
  repository_name = "${var.codecommit_repo}"
}

resource "aws_codebuild_project" "terraform_build" {
  name          = "terraform-build"
  description   = "Provision infrastructure with Terraform"
  build_timeout = "${var.build_timeout}"
  service_role  = "${aws_iam_role.codebuild_role.arn}"
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "${var.codebuild_image}"
    type         = "LINUX_CONTAINER"
    privileged_mode = false
    environment_variable {
      name = "AWS_ACCESS_KEY_ID"
      value = "${aws_ssm_parameter.aws_access_key.name}"
      type = "PARAMETER_STORE"
    }
    environment_variable {
      name = "AWS_SECRET_ACCESS_KEY"
      value = "${aws_ssm_parameter.aws_secret_key.name}"
      type = "PARAMETER_STORE"
    }
  }
  source {
    type     = "CODECOMMIT"
    location = "${aws_codecommit_repository.build_repo.clone_url_http}"
    buildspec = "codebuild/terraform/blueprint.yml"
  }
  tags {
    "Environment" = "Test"
  }
}
