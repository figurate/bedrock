/*
 * Provision an ECS cluster using CloudFormation stack.
 */
data "aws_caller_identity" "current" {}

data "aws_iam_role" "cloudformation" {
  name = "ecs-cloudformation-role"
}

data "aws_vpc" "tenant" {
  default = var.vpc_default
  tags    = var.vpc_tags
}

data "aws_availability_zones" "available_zones" {}

data "aws_subnet_ids" "tenant" {
  vpc_id = data.aws_vpc.tenant.id
  //  tags {
  //    Name = "private_subnet_*"
  //  }
}

resource "aws_cloudformation_stack" "ecs_cluster" {
  name         = local.cluster_name
  capabilities = ["CAPABILITY_IAM"]
  iam_role_arn = data.aws_iam_role.cloudformation.arn
  parameters = {
    VpcId                     = data.aws_vpc.tenant.id
    VpcCidrIp                 = data.aws_vpc.tenant.cidr_block
    LoadBalancerName          = "${local.cluster_name}-alb"
    LoadBalancerSubnets       = join(",", data.aws_subnet_ids.tenant.ids)
    TargetDeregistrationDelay = ""
    HealthCheckPath           = "/"
    CertificateArn            = aws_acm_certificate.ssl_certificate.arn
    ClusterName               = local.cluster_name
    ServiceDiscoveryName      = local.default_namespace
    RouteName                 = "${local.cluster_name}-${local.account_hash}"
    ServiceMeshEnabled        = var.servicemesh_enabled ? "true" : "false"
  }
  template_body = file(format("%s/%s.yml", var.cloudformation_path, var.cluster_template))
}
