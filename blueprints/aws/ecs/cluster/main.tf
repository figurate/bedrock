data "aws_caller_identity" "current" {}

data "aws_iam_role" "clusteradmin" {
  name = "ecs-bedrock-clusteradmin"
}

data "aws_vpc" "tenant" {
  default = var.vpc_default
  tags    = var.vpc_tags
}

data "aws_availability_zones" "available_zones" {}

data "aws_route53_zone" "tenant" {
  name = var.hosted_zone
  //  private_zone = true
}

data "aws_subnet_ids" "tenant" {
  vpc_id = data.aws_vpc.tenant.id
  //  tags {
  //    Name = "private_subnet_*"
  //  }
}

resource "tls_private_key" "ssl_certificate" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "ssl_certificate" {
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]
  key_algorithm         = "RSA"
  private_key_pem       = tls_private_key.ssl_certificate.private_key_pem
  validity_period_hours = 2160 // 6 months
  subject {
    common_name  = format("%s.service.internal", local.cluster_name)
    organization = ""
    country      = ""
  }
}

resource "aws_acm_certificate" "ssl_certificate" {
  private_key      = tls_private_key.ssl_certificate.private_key_pem
  certificate_body = tls_self_signed_cert.ssl_certificate.cert_pem
}

resource "aws_cloudformation_stack" "ecs_cluster" {
  name         = local.cluster_name
  capabilities = ["CAPABILITY_IAM"]
  iam_role_arn = data.aws_iam_role.clusteradmin.arn
  parameters {
    VpcId                     = data.aws_vpc.tenant.id
    VpcCidrIp                 = data.aws_vpc.tenant.cidr_block
    LoadBalancerName          = "${local.cluster_name}-alb"
    LoadBalancerSubnets       = join(",", data.aws_subnet_ids.tenant.ids)
    TargetGroupName           = local.cluster_name
    TargetDeregistrationDelay = ""
    HealthCheckPath           = "/"
    CertificateArn            = aws_acm_certificate.ssl_certificate.arn
    ClusterName               = local.cluster_name
    HostedZoneId              = data.aws_route53_zone.tenant.id
    RouteName                 = "${local.cluster_name}-${local.account_hash}"
  }
  template_body = file(format("%s/ecs_cluster.yml", var.cloudformation_path))
}
