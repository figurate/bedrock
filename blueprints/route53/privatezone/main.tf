data "aws_vpc" "default" {
  default = true
}

resource "aws_route53_zone" "primary" {
  name = "${var.fqdn}"

  vpc {
    vpc_id = "${data.aws_vpc.default.id}"
  }
}
