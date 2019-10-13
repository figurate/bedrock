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
    CertificateArn            = ""
    ClusterName               = local.cluster_name
    HostedZoneId              = data.aws_route53_zone.tenant.id
    RouteName                 = "${local.cluster_name}-${local.account_hash}"
  }
  template_body = file(format("%s/ecs_cluster.yml", var.cloudformation_path))
}
