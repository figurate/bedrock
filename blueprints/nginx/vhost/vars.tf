variable "template_path" {
  description = "The root path to vhost templates"
  default     = "templates"
}

variable "nginx_host" {
  description = "Host to install vhost configuration"
}

variable "ssh_user" {
  description = "Username for SSH to nginx host"
}

variable "ssh_private_key" {
  description = "Location of private key file for SSH access to reverseproxy host"
  default     = "~/.ssh/id_rsa"
}

variable "bastion_fqdn" {
  description = "Bastion host used to access reverse proxy"
}

variable "environment" {
  description = "Environment identifier for the reverse proxy"
}

variable "hostnames" {
  type        = "list"
  description = "Hostname to configure in virtual host"
}

variable "target_type" {
  description = "Indicates the type of vhost configuration to use"
}

variable "upstream_hosts" {
  type        = "list"
  description = "List of upstream hosts for vhost configuration"
  default     = []
}

variable "target_host" {
  description = "A target site for redirection of requests"
  default     = ""
}

variable "letsencrypt_email" {
  description = "Email address to register with Letsencrypt (leave blank to disable letsencrypt)"
  default     = ""
}

variable "error_bg_image" {
  description = "Path to background image used for error pages"
  default     = ""
}

variable "locations_config" {
  description = "A file containing NGINX location directives"
  default     = ""
}

variable "awstats_enabled" {
  description = "Write configuration file for awstats"
  default     = false
}

locals {
  uuid = "${var.environment}-${substr(sha256(var.hostnames[0]), -10, -1)}"
}
