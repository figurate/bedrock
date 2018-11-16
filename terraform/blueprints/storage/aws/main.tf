/**
 * # AWS S3 bucket configuration
 *
 * Provision an S3 bucket in AWS.
 */
provider "aws" {
  region = "${var.region}"
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "stack_templates" {
  bucket = "${data.aws_caller_identity.current.account_id}-${var.bucket_name}"
  acl    = "private"
  versioning {enabled = true}
}
