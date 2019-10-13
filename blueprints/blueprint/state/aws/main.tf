/**
 * # Terraform state (AWS) configuration
 *
 * Provision an S3 bucket for terraform state in AWS.
 */
data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "tf_state" {
  bucket = "${data.aws_caller_identity.current.account_id}-terraform-state"
  acl    = "private"
  versioning { enabled = true }
}

resource "aws_s3_bucket_public_access_block" "tf_state" {
  bucket                  = aws_s3_bucket.tf_state.id
  restrict_public_buckets = "true"
}

resource "aws_dynamodb_table" "tf_state_lock" {
  name     = "terraform-lock"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  billing_mode = "PAY_PER_REQUEST"
}
