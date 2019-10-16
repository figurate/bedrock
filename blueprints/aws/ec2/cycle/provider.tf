provider "aws" {
  version = ">= 2.7.0"
  assume_role {
    role_arn = "arn:aws:iam::${var.assume_role_account}:role/bedrock-ec2-admin"
  }
}

variable "assume_role_account" {
  description = "AWS account ID for the role to assume into"
}
