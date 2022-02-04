/**
 * # AWS S3 bucket configuration
 *
 * Provision an S3 bucket in AWS.
 */
data "aws_caller_identity" "current" {}

data "aws_s3_bucket" "access_log" {
  bucket = "${data.aws_caller_identity.current.account_id}-${var.access_log_bucket}"
}

data "archive_file" "package" {
  output_path = "package.zip"
  type = "zip"
  source_dir = var.content_path
  excludes = var.excludes
}

resource "aws_kms_key" "encrypted_bucket" {
  description = "Encryption key for ${var.bucket_name} S3 bucket"
}

resource "aws_kms_alias" "encrypted_bucket" {
  target_key_id = aws_kms_key.encrypted_bucket.id
  name = "alias/${var.bucket_name}"
}

module "encrypted_bucket" {
  source = "micronode/s3-bucket/aws//modules/encrypted"

  bucket = "${data.aws_caller_identity.current.account_id}-${var.bucket_name}"
  expiration_days = var.object_expires
  versioned = var.version_enabled
  encryption_key = aws_kms_key.encrypted_bucket.id
  logging_bucket = data.aws_s3_bucket.access_log.id
}

resource "null_resource" "package_sync" {
  triggers = {
    content_path = sha256(var.content_path)
    includes = sha256(join(",", var.includes))
    excludes = sha256(join(",", var.excludes))
    delete_flag = sha256(var.delete)
    package_hash = data.archive_file.package.output_sha
  }
  provisioner "local-exec" {
    command = <<EOF
aws s3 sync \
    ${length(var.excludes) > 0 ? local.excludes_string : ""} \
    ${length(var.includes) > 0 ? local.includes_string : ""} \
    ${var.delete == "true" ? "--delete" : ""} \
    ${var.content_path} s3://${module.encrypted_bucket.bucket_id}
EOF
  }
  depends_on = [module.encrypted_bucket]
}
