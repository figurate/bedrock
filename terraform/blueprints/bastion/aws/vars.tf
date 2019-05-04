variable "userdata_path" {
  description = "The root path to userdata templates"
  default = "userdata"
}

variable "bastion_user" {
  description = "Username for bastion SSH user"
}

variable "ssh_key" {
  description = "Location of public key file for SSH access to droplets"
  default = "~/.ssh/id_rsa.pub"
}

variable "image_name" {
  description = "AWS image for bastion instance"
  default = "amzn2-ami-hvm-*"
}

variable "image_owner" {
  description = "AMI image owner (leave blank for current account)"
  default = "137112412989"
}

variable "image_os" {
  description = <<EOF
The operating system installed on the selected AMI. Valid values are:

  * al2     = Amazon Linux 2
  * ubuntu  = Ubuntu
EOF
  default = "al2"
}

variable "instance_type" {
  description = "AWS instance type for bastion"
  default = "t3.nano"
}

variable "enabled" {
  description = "Start/stop the bastion host"
}

variable "shutdown_delay" {
  description = "Number of minutes before the host will automatically shutdown"
  default = 60
}
