/**
 * # AWS Bastion host configuration
 *
 * Provision an EC2 instance with SSH ingress authenticated with the specified public key.
 */
data "aws_caller_identity" "current" {}

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

resource "aws_iam_user_ssh_key" "aws_ssh_key" {
  encoding = "SSH"
  public_key = "${file(var.ssh_key)}"
  username = "${var.bastion_user}"
}

resource "aws_security_group" "bastion_sg" {
  name = "bastion-sg"
  ingress {
    from_port = 22
    protocol = "TCP"
    to_port = 22
  }
}

resource "aws_instance" "bastion" {
  count = "${replace(replace(var.enabled, "/false/", 0), "/true/", 1)}"
  ami = "${data.aws_ami.bastion_image.id}"
  instance_type = "${var.instance_type}"
  security_groups = ["${aws_security_group.bastion_sg.id}"]
}
