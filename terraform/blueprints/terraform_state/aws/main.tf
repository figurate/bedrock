provider "aws" {}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "tf_state" {
  bucket = "${data.aws_caller_identity.current.account_id}-terraform-state"
  acl = "private"
  versioning {enabled = true}
}
