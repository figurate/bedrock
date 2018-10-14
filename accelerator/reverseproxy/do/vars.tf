variable "do_token" {
  description = "Digital Ocean API token"
}

variable "do_region" {
  description = "Digital Ocean region"
}

variable "ssh_key" {
  description = "Identifier of public key file for SSH access to droplets"
}

variable "reverseproxy_image" {
  description = "Digital Ocean image for reverseproxy droplet"
  default = "ubuntu-18-04-x64"
}

variable "enabled" {
  description = "Start/stop the reverseproxy host"
}

variable "environment" {
  description = "Environment identifier for the reverseproxy host"
}

variable "upstream_ports" {
  type = "list"
  description = "A list of ports to route upstream traffic"
  default = ["8080"]
}

variable "amplify_key" {
  description = "API key for nginx amplify"
}

locals {
  uuid = "${var.environment}-reverseproxy"
}
