provider "aws" {
  region = "${var.region}"
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
  count = "${replace(replace(var.enabled, "/false/", 0), "/true", 1)}"
  ami = "${var.bastion_image}"
  instance_type = "${var.instance_type}"
  security_groups = ["${aws_security_group.bastion_sg.id}"]
}
