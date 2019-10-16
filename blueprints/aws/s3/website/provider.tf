provider "aws" {
  version = ">= 2.7.0"
  assume_role {
    role_arn = "arn:aws:iam::${var.assume_role_account}:role/bedrock-s3-admin"
  }
}

variable "assume_role_account" {
  description = "AWS account ID for the role to assume into"
}

provider "null" {
  version = ">= 2.1.0"
}

provider "archive" {
  version = ">= 1.2.0"
}