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

variable "enabled" {
  description = "Start/stop the bastion host"
}

locals {
  uuid = "bastion"
}
