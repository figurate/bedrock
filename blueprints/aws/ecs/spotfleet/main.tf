/*
 * Provision a Spotfleet for an ECS cluster using CloudFormation stack.
 */
data "aws_caller_identity" "current" {}

data "aws_iam_role" "cloudformation" {
  name = "ecs-cloudformation-role"
}

data "aws_iam_role" "spotfleet" {
  name = "ecs-spotfleet-role"
}

data "aws_iam_role" "autoscaling" {
  name = "ecs-autoscaling-role"
}

data "aws_iam_instance_profile" "clusternode" {
  name = "ecs-clusternode-instanceprofile"
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

data "aws_ami" "clusternode" {
  filter {
    name   = "name"
    values = [var.image_name]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
  most_recent = true
  owners      = [replace(var.image_owner, "/\\A\\z/", data.aws_caller_identity.current.account_id)]
}

data "aws_security_group" "clusternode" {
  name = "${local.cluster_name}-NodeSG"
}

resource "aws_cloudformation_stack" "ecs_spotfleet" {
  name         = "${local.cluster_name}-spotfleet"
  capabilities = ["CAPABILITY_IAM"]
  iam_role_arn = data.aws_iam_role.cloudformation.arn
  parameters = {
    ClusterName                = local.cluster_name
    AmiId                      = data.aws_ami.clusternode.id
    InstanceType               = var.instance_type
    AvailabilityZones          = join(",", data.aws_availability_zones.available_zones.names)
    ClusterNodeSubnets         = join(",", data.aws_subnet_ids.tenant.ids)
    ClusterNodesMin            = var.nodes_min
    ClusterNodesMax            = var.nodes_max
    ClusterNodesDesired        = var.nodes_desired
    ClusterNodeSG              = data.aws_security_group.clusternode.id
    ClusterNodeInstanceProfile = data.aws_iam_instance_profile.clusternode.arn
    ClusterSpotFleetRole       = data.aws_iam_role.spotfleet.arn
    ClusterAutoscalingRole     = data.aws_iam_role.autoscaling.arn
  }
  template_body = file(format("%s/%s.yml", var.cloudformation_path, var.cluster_template))
}
