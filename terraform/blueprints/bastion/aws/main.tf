/**
 * # AWS Bastion host configuration
 *
 * Provision an EC2 instance with SSH ingress authenticated with the specified public key.
 */
data "aws_caller_identity" "current" {}

data "aws_vpc" "default" {
  //  default = true
  filter {
    name = "tag:Environment"
    values = ["dev"]
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = "${data.aws_vpc.default.id}"
  tags {
    Name = "public_subnet_*"
  }
}

data "aws_ami" "bastion_image" {
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

data "template_file" "userdata" {
  template = "${file(format("%s/%s.yml", var.userdata_path, var.image_os))}"
  vars {
    AuthorizedUserName = "${var.bastion_user}"
    AuthorizedUserSSHKey = "${file(var.ssh_key)}"
    ShutdownDelay = "${var.shutdown_delay}"
  }
}

data "aws_iam_role" "instance" {
  name = "bedrock-bastion-instance"
}

resource "aws_security_group" "bastion" {
  name = "bastion-sg"
  ingress {
    protocol = "TCP"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol = "TCP"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol = "TCP"
    from_port = 443
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_instance_profile" "bastion" {
  name = "bedrock-bastion-instance"
  role = "${data.aws_iam_role.instance.name}"
}

resource "aws_instance" "bastion" {
  count = "${replace(replace(var.enabled, "/false/", 0), "/true/", 1)}"
  ami = "${data.aws_ami.bastion_image.id}"
  instance_type = "${var.instance_type}"
  security_groups = ["${aws_security_group.bastion.name}"]
  user_data = "${data.template_file.userdata.rendered}"
  iam_instance_profile = "${aws_iam_instance_profile.bastion.name}"
  instance_initiated_shutdown_behavior = "terminate"
  tags {
    Name = "bastion"
  }
  vpc_security_group_ids = ["${data.aws_subnet_ids.public.ids}"]
}
