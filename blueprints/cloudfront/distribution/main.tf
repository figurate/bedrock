data "aws_caller_identity" "current" {}

data "aws_s3_bucket" "access_log" {
  bucket = "${replace(var.access_log_bucket, "/\\A\\z/", format("%s-access-logs", data.aws_caller_identity.current.account_id))}"
}

data "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}"
}

data "aws_route53_zone" "primary" {
  name = "${var.hosted_zone}."
}

//Function must live in us-east-1 and Terraform can't lookup across regions
//data "aws_lambda_function" "url_rewrite" {
//  function_name = "CloudFrontRewrite"
//}

resource "aws_cloudfront_distribution" "distribution" {
  enabled             = "${var.enabled}"
  price_class         = "${var.price_class}"
  default_root_object = "${var.default_root_object}"

  custom_error_response {
    error_code         = 404
    response_page_path = "${var.error_page}"
    response_code      = 404
  }

  aliases = "${var.aliases}"

  "origin" {
    domain_name = "${data.aws_s3_bucket.bucket.bucket_domain_name}"
    origin_id   = "S3-${data.aws_s3_bucket.bucket.bucket}"
  }

  "default_cache_behavior" {
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    "forwarded_values" {
      "cookies" {
        forward = "none"
      }

      query_string = false
    }

    target_origin_id = "S3-${data.aws_s3_bucket.bucket.bucket}"
    default_ttl      = "${var.default_ttl}"
  }

  ordered_cache_behavior {
    path_pattern           = "*+*"
    viewer_protocol_policy = "allow-all"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    "forwarded_values" {
      "cookies" {
        forward = "none"
      }

      query_string = false
    }

    target_origin_id = "S3-${data.aws_s3_bucket.bucket.bucket}"
    default_ttl      = "${var.default_ttl}"

    lambda_function_association {
      event_type   = "viewer-request"
      lambda_arn   = "arn:aws:lambda:us-east-1:${data.aws_caller_identity.current.account_id}:function:CloudFrontRewrite:1"
      include_body = false
    }
  }

  logging_config {
    bucket = "${data.aws_s3_bucket.access_log.bucket_domain_name}"
    prefix = "cloudfront-${data.aws_s3_bucket.bucket.bucket}/"
  }

  "restrictions" {
    "geo_restriction" {
      restriction_type = "none"
    }
  }

  "viewer_certificate" {
    cloudfront_default_certificate = true

    //    minimum_protocol_version = "TLSv1.2_2018"
  }
}

resource "aws_route53_record" "www" {
  count   = "${length(var.aliases)}"
  zone_id = "${data.aws_route53_zone.primary.zone_id}"
  name    = "${element(var.aliases, count.index)}"
  type    = "CNAME"

  alias {
    evaluate_target_health = false
    name                   = "${aws_cloudfront_distribution.distribution.id}"
    zone_id                = "${data.aws_route53_zone.primary.zone_id}"
  }
}
