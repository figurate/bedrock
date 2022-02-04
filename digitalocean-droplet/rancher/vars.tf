variable "template_path" {
  description = "The root path to userdata templates"
  default     = "templates"
}

variable "do_region" {
  description = "Digital Ocean region"
}

variable "ssh_user" {
  description = "Username for SSH user"
}

variable "ssh_key" {
  description = "Identifier of public key file for SSH access to droplets"
}

variable "ssh_private_key" {
  description = "Location of private key file for SSH access to droplets"
//  default     = "~/.ssh/id_rsa"
}

variable "rancher_image" {
  description = "Digital Ocean image for rancher server droplet"
  default     = "ubuntu-18-04-x64"
}

variable "image_os" {
  description = <<EOF
The operating system installed on the selected AMI. Valid values are:

  * ubuntu  = Ubuntu
EOF
  default = "ubuntu"
}

variable "enabled" {
  description = "Start/stop the rancher server host"
  default = "true"
}

variable "environment" {
  description = "Environment identifier for the rancher hosts"
}

variable "nginx_host" {
  description = "Host to install vhost configuration"
}

variable "bastion_fqdn" {
  description = "Bastion host used to access reverse proxy"
}

variable "papertrail_host" {
  description = "Target URL for Papertrail logs"
  default = ""
}

variable "papertrail_port" {
  description = "Target port for Papertrail logs"
  default = ""
}

variable "floatingip_addresses" {
  type = "list"
  description = "Floating IP addresses to associate with the droplets (count must not exceed number of instances)"
  default = []
}

variable "apex_domain" {
  description = "Root domain for private DNS records"
  default = "service.internal"
}

locals {
  uuid = "${var.environment}-rancher"
}
