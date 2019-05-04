/**
 * # AWS reverse proxy configuration
 *
 * Provision an NGINX reverse proxy for an environment.
 */
data "aws_caller_identity" "current" {}

data "aws_vpc" "default" {
//  default = true
  filter {
    name = "tag:Environment"
    values = ["${var.environment}"]
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = "${data.aws_vpc.default.id}"
  tags {
    Name = "public_subnet_*"
  }
}

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
    PapertrailHost = "${var.papertrail_host}"
    PapertrailPort = "${var.papertrail_port}"
    NginxAmplifyKey = "${var.amplify_key}"
  }
}

resource "aws_cloudformation_stack" "reverseproxy" {
  name = "${var.environment}-reverseproxy"
  capabilities = ["CAPABILITY_IAM"]
  iam_role_arn = "${data.aws_iam_role.nginx_cloudformation.arn}"
  parameters {
    Environment = "${var.environment}"
    KeyPair = ""
    VpcId = "${data.aws_vpc.default.id}"
    SubnetId = "${data.aws_subnet_ids.public.ids[0]}"
    ImageId = "${data.aws_ami.autoscaling_image.image_id}"
    InstanceType = "${var.instance_type}"
    UserData = "${base64encode(data.template_file.userdata.rendered)}"
  }
  template_body = "${file(format("%s/reverseproxy.yml", var.cloudformation_path))}"
}
