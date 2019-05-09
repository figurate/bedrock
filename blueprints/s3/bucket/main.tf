/**
 * # AWS S3 bucket configuration
 *
 * Provision an S3 bucket in AWS.
 */
data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "bucket" {
  bucket = "${data.aws_caller_identity.current.account_id}-${var.bucket_name}"
  acl    = "private"
  versioning {
    enabled = "${var.version_enabled}"
  }
  lifecycle_rule {
    id = "object_expiry"
    enabled = "${var.object_expires > 0}"
    expiration {
      days = "${var.object_expires}"
    }
  }
}
