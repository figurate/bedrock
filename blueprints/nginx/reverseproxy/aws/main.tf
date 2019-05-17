/**
 * # AWS reverse proxy configuration
 *
 * Provision an NGINX reverse proxy for an environment.
 */
data "aws_caller_identity" "current" {}

data "aws_vpc" "default" {
  default = true
//  filter {
//    name = "tag:Environment"
//    values = ["${var.environment}"]
//  }
}

//data "aws_subnet_ids" "default" {
//  vpc_id = "${data.aws_vpc.default.id}"
//  tags {
//    Name = "${var.subnet}"
//  }
//}

data "aws_ami" "autoscaling_image" {
  filter {
    name = "name"
    values = ["${var.image_name}"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  most_recent = true
  owners = ["${replace(var.image_owner, "/\\A\\z/", data.aws_caller_identity.current.account_id)}"]
}

data "aws_iam_role" "nginx_cloudformation" {
  name = "bedrock-nginx-cloudformation"
}

data "template_file" "userdata" {
  template = "${file(format("%s/%s.yml", var.userdata_path, var.image_os))}"
  vars {
    NginxAmplifyKey = "${var.amplify_key}"
    NginxHostname = "${var.environment}-reverseproxy"
    AuthorizedUserName = "${var.reverseproxy_user}"
    AuthorizedUserSSHKey = "${replace(var.ssh_key, "/\\A\\z/", file(var.ssh_key_file))}"
  }
}

resource "aws_cloudformation_stack" "reverseproxy" {
  name = "${var.environment}-reverseproxy"
  capabilities = ["CAPABILITY_IAM"]
  iam_role_arn = "${data.aws_iam_role.nginx_cloudformation.arn}"
  parameters {
    Environment = "${var.environment}"
//    KeyPair = ""
    VpcId = "${data.aws_vpc.default.id}"
    VpcCidrBlock = "${data.aws_vpc.default.cidr_block}"
//    SubnetId = "${data.aws_subnet_ids.default.ids[0]}"
    ImageId = "${data.aws_ami.autoscaling_image.image_id}"
    InstanceType = "${var.instance_type}"
    UserData = "${base64encode(data.template_file.userdata.rendered)}"
    PublicHostedZoneName = "${var.public_zone}."
    PrivateHostedZoneName = "${var.private_zone}."
    PublicRouteName = "${var.environment}-reverseproxy.${var.public_zone}"
    PrivateRouteName = "${var.environment}-reverseproxy.${var.private_zone}"
  }
  template_body = "${file(format("%s/reverseproxy.yml", var.cloudformation_path))}"
}
