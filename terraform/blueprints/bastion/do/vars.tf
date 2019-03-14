variable "userdata_path" {
  description = "The root path to userdata templates"
  default = "userdata"
}

variable "bastion_user" {
  description = "Username for bastion SSH user"
}

variable "ssh_key" {
  description = "Identifier of public key file for SSH access to droplets"
}

variable "ssh_private_key" {
  description = "Location of private key file for SSH access to droplets"
  default = "~/.ssh/id_rsa"
}

variable "bastion_image" {
  description = "Digital Ocean image for bastion droplet"
  default = "ubuntu-18-04-x64"
}

variable "image_os" {
  description = <<EOF
The operating system installed on the selected droplet. Valid values are:

  * ubuntu  = Ubuntu
EOF
  default = "ubuntu"
}

variable "enabled" {
  description = "Start/stop the bastion host"
}

variable "shutdown_delay" {
  description = "Number of minutes before the host will automatically shutdown"
  default = 60
}

locals {
  uuid = "bastion"
}
