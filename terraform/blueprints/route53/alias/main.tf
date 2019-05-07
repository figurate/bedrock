data "aws_route53_zone" "primary" {
  name = "${local.hosted_zone}."
}

resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.primary.zone_id}"
  name    = "${var.fqdn}"
  type    = "${var.record_type}"
  alias {
    evaluate_target_health = false
    name = "${var.target}"
    zone_id = "${data.aws_route53_zone.primary.zone_id}"
  }
}
