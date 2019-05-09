resource "aws_route53_zone" "primary" {
  name = "${var.fqdn}"
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid = "PublicReadGetObject"
    effect = "Allow"
    principals {
      identifiers = ["*"]
      type = "AWS"
    }
    actions = ["s3:GetObject"]
    resources = ["arn:aws:s3:::${var.fqdn}/*"]
    condition {
      test = "IpAddress"
      variable = "aws:SourceIp"
      values = "${var.source_cidrs}"
    }
  }
}

resource "aws_s3_bucket" "apex_redirect" {
  count = "${length(var.apex_redirect_fqdn) > 0 ? 1 : 0}"
  bucket = "${var.fqdn}"
  acl    = "public-read"
  policy = "${data.aws_iam_policy_document.bucket_policy.json}"
  website {
    redirect_all_requests_to = "${var.apex_redirect_fqdn}"
  }
}

resource "aws_route53_record" "www" {
  count = "${length(var.apex_redirect_fqdn) > 0 ? 1 : 0}"
  zone_id = "${aws_route53_zone.primary.zone_id}"
  name    = "${var.fqdn}"
  type    = "A"
  alias {
    evaluate_target_health = false
    name = "${aws_s3_bucket.apex_redirect.website_domain}"
    zone_id = "${aws_s3_bucket.apex_redirect.hosted_zone_id}"
  }
}
