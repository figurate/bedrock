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

data "aws_iam_role" "codebuild" {
  name = "bedrock-codebuild-role"
}

data "aws_s3_bucket" "blueprints" {
  bucket = "${data.aws_caller_identity.current.account_id}-${var.blueprints_bucket}"
}

resource "aws_codebuild_project" "blueprint" {
  name          = "blueprint"
  description   = "Provision infrastructure with bedrock blueprint"
  build_timeout = "${var.build_timeout}"
  service_role  = "${data.aws_iam_role.codebuild.arn}"
  encryption_key = "${aws_kms_key.build_params.id}"
  source {
    type     = "NO_SOURCE"
    buildspec = "${var.buildspec}"
  }
  secondary_sources {
    type = "S3"
    source_identifier = "package"
    location = "${data.aws_s3_bucket.blueprints.bucket}/package.zip"
  }
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "${var.codebuild_image}"
    type         = "LINUX_CONTAINER"
    privileged_mode = true
    environment_variable {
      name = "AWS_DEFAULT_REGION"
      value = "${var.region}"
    }
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
  tags {
    "Environment" = "Test"
  }
}
