provider "aws" {
  region = "${var.region}"
  assume_role {
    role_arn = "arn:aws:iam::${var.assume_role_account}:role/bedrock-s3-admin"
  }
}

variable "region" {
  description = "AWS default region"
}

variable "assume_role_account" {
  description = "AWS account ID for the role to assume into"
}

provider "null" {
  version = "~> 1.0"
}
