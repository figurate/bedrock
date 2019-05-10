provider "aws" {
  region = "${var.region}"
  assume_role {
    role_arn = "arn:aws:iam::${var.assume_role_account}:role/bedrock-codebuild-admin"
  }
}

variable "region" {
  description = "AWS default region"
}

variable "assume_role_account" {
  description = "AWS account ID for the role to assume into"
}
