provider "aws" {
  version = ">= 2.7.0"
  region  = "${var.region}"
  assume_role {
    role_arn = "arn:aws:iam::${var.assume_role_account}:role/bedrock-cognito-admin"
  }
}

variable "region" {
  description = "AWS default region"
}

variable "assume_role_account" {
  description = "AWS account ID for the role to assume into"
}
