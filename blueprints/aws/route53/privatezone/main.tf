data "aws_vpc" "tenant" {
  default = "${var.vpc_default}"
  tags    = "${var.vpc_tags}"
}

resource "aws_route53_zone" "primary" {
  name = "${var.fqdn}"

  vpc {
    vpc_id = "${data.aws_vpc.tenant.id}"
  }
}
