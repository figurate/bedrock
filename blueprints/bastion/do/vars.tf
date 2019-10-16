variable "template_path" {
  description = "The root path to templates"
  default     = "templates"
}

variable "do_region" {
  description = "Digital Ocean region"
}

variable "ssh_user" {
  description = "Username for bastion SSH user"
}

variable "ssh_key" {
  description = "Identifier of public key file for SSH access to droplets"
}

variable "ssh_private_key" {
  description = "Location of private key file for SSH access to droplets"
  default     = "~/.ssh/id_rsa"
}

variable "droplet_image" {
  description = "Digital Ocean image for droplet"
  default     = "ubuntu-18-04-x64"
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
  default = "true"
}

variable "floatingip_addresses" {
  type = "list"
  description = "Floating IP addresses to associate with the droplets (count must not exceed number of instances)"
  default = []
}

variable "upstream_tags" {
  type = "list"
  description = "A list of firewall tags to route upstream traffic"
  default = ["reverseproxy"]
}

variable "apex_domain" {
  description = "Root domain for private DNS records"
  default = "service.internal"
}

variable "shutdown_delay" {
  description = "Number of minutes before the host will automatically shutdown"
  default = 60
}

locals {
  uuid = "bastion"
}
