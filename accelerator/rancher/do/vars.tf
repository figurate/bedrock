variable "do_token" {
  description = "Digital Ocean API token"
}

variable "do_region" {
  description = "Digital Ocean region"
}

variable "ssh_key" {
  description = "Identifier of public key file for SSH access to droplets"
}

variable "rancher_image" {
  description = "Digital Ocean image for rancher server droplet"
}

variable "enabled" {
  description = "Start/stop the rancher server host"
}

variable "environment" {
  description = "Environment identifier for the rancher hosts"
}
