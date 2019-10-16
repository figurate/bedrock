/**
 * # AWS Sling host configuration
 *
 * Provision an EC2 instance with Apache Sling installed.
 */
data "aws_caller_identity" "current" {}

data "aws_vpc" "tenant" {
  default = var.vpc_default
  tags    = var.vpc_tags
}

//data "aws_subnet_ids" "default" {
//  vpc_id = "${data.aws_vpc.default.id}"
//  tags {
//    Name = "${var.subnet}"
//  }
//}

data "aws_ami" "sling_image" {
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

data "aws_iam_role" "sling_cloudformation" {
  name = "bedrock-apachesling-cloudformation"
}

data "template_file" "userdata" {
  template = file(format("%s/%s.yml", var.template_path, var.image_os))

  vars = {
    AuthorizedUserName = var.ssh_user

    //    AuthorizedUserSSHKey = "${replace(var.ssh_key, "/\\A\\z/", file(var.ssh_key_file))}"
    AuthorizedUserSSHKey = replace(var.ssh_key, "/\\A\\z/", "")
    SlingHostname        = "${var.environment}-apachesling"
    SlingVersion         = var.sling_version
  }
}

resource "aws_cloudformation_stack" "sling" {
  name         = "${var.environment}-apachesling"
  capabilities = ["CAPABILITY_IAM"]
  iam_role_arn = data.aws_iam_role.sling_cloudformation.arn

  parameters = {
    Environment = var.environment

    //    KeyPair = ""
    VpcId        = data.aws_vpc.tenant.id
    VpcCidrBlock = data.aws_vpc.tenant.cidr_block

    //    SubnetId = "${data.aws_subnet_ids.default.ids[0]}"
    ImageId        = data.aws_ami.sling_image.image_id
    InstanceType   = var.instance_type
    UserData       = base64encode(data.template_file.userdata.rendered)
    HostedZoneName = "${var.hosted_zone}."
    RouteName      = "${var.environment}-apachesling.${var.hosted_zone}"
  }

  template_body = file(format("%s/apachesling.yml", var.cloudformation_path))
}
