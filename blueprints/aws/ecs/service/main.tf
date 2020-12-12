data "aws_iam_role" "serviceadmin" {
  name = "bedrock-ecs-service-admin"
}

data "aws_alb" "cluster_alb" {
  name = "${var.cluster_name}"
}

data "aws_route53_zone" "internal" {
  name         = "internal."
  private_zone = true
}

resource "aws_cloudformation_stack" "ecs_service" {
  name         = "${var.service_name}-ecs-service"
  iam_role_arn = "${data.aws_iam_role.serviceadmin.arn}"
  parameters {
    ClusterName  = ""
    HostedZoneId = ""
    RouteName    = ""
  }
  template_body = "${file(format("%s/ecs_service.yml", var.cloudformation_path))}"
}

resource "aws_route53_record" "ecs_service" {
  name    = "${local.env_string}-${var.service_name}"
  type    = "A"
  zone_id = "${data.aws_route53_zone.internal.zone_id}"
  alias {
    evaluate_target_health = false
    name                   = "${data.aws_alb.cluster_alb.dns_name}"
    zone_id                = "${data.aws_alb.cluster_alb.zone_id}"
  }
}
