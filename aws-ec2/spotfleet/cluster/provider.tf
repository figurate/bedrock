provider "aws" {
  version = ">= 2.7.0"
  region = "${var.region}"
}

variable "region" {
  description = "AWS default region"
}
