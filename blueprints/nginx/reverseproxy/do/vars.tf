variable "template_path" {
  description = "The root path to userdata templates"
  default     = "templates"
}

variable "do_region" {
  description = "Digital Ocean region"
}

variable "instance_count" {
  description = "Number of hosts to provision"
  default     = 1
}

variable "ssh_user" {
  description = "Username for reverseproxy SSH user"
}

variable "ssh_key" {
  description = "Identifier of public key file for SSH access to droplets"
}

variable "droplet_image" {
  description = "Digital Ocean image for droplet"
  default     = "ubuntu-18-04-x64"
}

variable "image_os" {
  description = <<EOF
The operating system installed on the selected AMI. Valid values are:

  * ubuntu  = Ubuntu
EOF
  default = "ubuntu"
}

variable "environment" {
  description = "Environment identifier for the reverseproxy host"
}

variable "upstream_ports" {
  type = "list"
  description = "A list of ports to route upstream traffic"
  default = ["8080"]
}

variable "upstream_tags" {
  type = "list"
  description = "A list of firewall tags to route upstream traffic"
  default = []
}

variable "upstream_addresses" {
  type = "list"
  description = "A list of IP addresses to route upstream traffic"
  default = []
}

variable "amplify_key" {
  description = "API key for nginx amplify"
  default = ""
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
  uuid = "${var.environment}-reverseproxy"
}
