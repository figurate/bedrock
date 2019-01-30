variable "bastion_user" {
  description = "Username for bastion SSH user"
}

variable "ssh_key" {
  description = "Location of public key file for SSH access to droplets"
}

variable "image_name" {
  description = "AWS image for bastion instance"
  default = "amzn2-ami-hvm-*"
}

variable "image_owner" {
  description = "AMI image owner (leave blank for current account)"
  default = "137112412989"
}

variable "instance_type" {
  description = "AWS instance type for bastion"
  default = "t3.micro"
}

variable "enabled" {
  description = "Start/stop the bastion host"
}
