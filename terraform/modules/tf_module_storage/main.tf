data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "tf_modules" {
  bucket = "${data.aws_caller_identity.current.account_id}-terraform-modules"
  acl = "private"
  versioning {enabled = true}
}
