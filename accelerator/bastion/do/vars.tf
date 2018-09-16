variable "do_token" {
  description = "Digital Ocean API token"
}

variable "do_region" {
  description = "Digital Ocean region"
}

variable "ssh_key" {
  description = "Identifier of public key file for SSH access to droplets"
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
