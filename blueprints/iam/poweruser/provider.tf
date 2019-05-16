provider "aws" {
  region = "${var.region}"
}

variable "region" {
  description = "AWS default region"
}
