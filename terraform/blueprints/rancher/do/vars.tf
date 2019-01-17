variable "do_token" {
  description = "Digital Ocean API token"
}

variable "do_region" {
  description = "Digital Ocean region"
}

variable "ssh_key" {
  description = "Identifier of public key file for SSH access to droplets"
}

variable "ssh_private_key" {
  description = "Location of private key file for SSH access to droplets"
  default = "~/.ssh/id_rsa"
}

variable "rancher_image" {
  description = "Digital Ocean image for rancher server droplet"
  default = "ubuntu-18-04-x64"
}

variable "enabled" {
  description = "Start/stop the rancher server host"
}

variable "environment" {
  description = "Environment identifier for the rancher hosts"
}

variable "hostname" {
  description = "Hostname to configure in virtual host"
  default = "rancher.mnode.org"
}

variable "reverseproxy_host" {
  description = "Host to install vhost configuration"
}

variable "bastion_host" {
  description = "Bastion host used to access reverse proxy"
}

locals {
  uuid = "${var.environment}-rancher"
}
