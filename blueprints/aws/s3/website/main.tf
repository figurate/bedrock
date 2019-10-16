/**
 * # AWS S3 website configuration
 *
 * Provision a static website using an S3 bucket in AWS.
 */
data "aws_caller_identity" "current" {}

data "aws_s3_bucket" "access_log" {
  bucket = replace(var.access_log_bucket, "/\\A\\z/", format("%s-access-logs", data.aws_caller_identity.current.account_id))
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"
    principals {
      identifiers = ["*"]
      type        = "AWS"
    }
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.fqdn}/*"]
    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = var.source_cidrs
    }
  }
}

data "archive_file" "content" {
  output_path = "content.zip"
  type        = "zip"
  source_dir  = var.content_path
}

data "aws_route53_zone" "primary" {
  name = "${local.hosted_zone}."
}

resource "aws_s3_bucket" "website" {
  bucket = var.fqdn
  acl    = "public-read"
  policy = data.aws_iam_policy_document.bucket_policy.json
  website {
    index_document = var.index_page
    error_document = var.error_page
    routing_rules  = var.routing_rules
  }
  logging {
    target_bucket = data.aws_s3_bucket.access_log.id
    target_prefix = "${var.fqdn}/"
  }
  versioning {
    enabled = var.version_enabled
  }
  lifecycle_rule {
    id      = "expire_old_versions"
    enabled = var.version_enabled
    noncurrent_version_expiration {
      days = var.object_expiration
    }
  }
}

resource "null_resource" "content_sync" {
  triggers = {
    content_path = sha256(var.content_path)
    includes     = sha256(join(",", var.includes))
    excludes     = sha256(join(",", var.excludes))
    delete_flag  = sha256(var.delete)
    content_hash = data.archive_file.content.output_sha
  }
  provisioner "local-exec" {
    command = <<EOF
aws s3 sync \
    ${length(var.excludes) > 0 ? local.excludes_string : ""} \
    ${length(var.includes) > 0 ? local.includes_string : ""} \
    ${var.delete == "true" ? "--delete" : ""} \
    ${var.content_path} s3://${aws_s3_bucket.website.id}
EOF
  }
  depends_on = ["aws_s3_bucket.website"]
}

resource "aws_route53_record" "www" {
  count = replace(replace(var.create_route53_record, "/true/", 1), "/false/", 0)
  zone_id = data.aws_route53_zone.primary.zone_id
  name = var.fqdn
  type = "A"
  alias {
    evaluate_target_health = false
    name = aws_s3_bucket.website.website_domain
    zone_id = aws_s3_bucket.website.hosted_zone_id
  }
}
