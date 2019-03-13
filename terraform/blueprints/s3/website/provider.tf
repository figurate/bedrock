provider "aws" {
  region = "${var.region}"
}

variable "region" {
  description = "AWS default region"
}

provider "null" {
  version = "~> 1.0"
}
