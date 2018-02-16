data "aws_caller_identity" "current" {}

resource "aws_codebuild_project" "ami-build" {
  name         = "puppet-ami-build"
  description  = "Build AMI configured with Puppet"
  build_timeout      = "15"
  service_role = "${aws_iam_role.codebuild_role.arn}"
  artifacts {
    type = "NO_ARTIFACTS"
  }
  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/ubuntu-base:14.04"
    type         = "LINUX_CONTAINER"
    privileged_mode = false
  }
  source {
    type     = "CODECOMMIT"
    location = "https://git-codecommit.ap-southeast-2.amazonaws.com/v1/repos/xxxxx"
    buildspec = "codebuild/ami/puppet.yml"
  }
  tags {
    "Environment" = "Test"
  }
}

resource "aws_codepipeline" "puppet_ami_pipeline" {
  name     = "puppet_ami_pipeline"
  role_arn = "${aws_iam_role.codepipeline_role.arn}"

  artifact_store {
    location = "${aws_s3_bucket.artifacts.bucket}"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      run_order = 1
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = [
        "xxxxx"
      ]
      input_artifacts = []

      configuration {
        RepositoryName       = "xxxx"
        BranchName     = "master"
        PollForSourceChanges  = true
      }
    }
  }

  stage {
    name = "Build"

    action {
      name            = "Build"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = [
        "xxxxx"
      ]
      output_artifacts = [
        "build_xxxxx"
      ]
      version         = "1"
      run_order = 1

      configuration {
        ProjectName = "puppet-ami-build"
      }
    }
  }
}
