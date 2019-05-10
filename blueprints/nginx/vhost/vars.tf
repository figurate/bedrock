variable "template_path" {
  description = "The root path to vhost templates"
  default = "templates"
}

variable "reverseproxy_host" {
  description = "Host to install vhost configuration"
}

variable "reverseproxy_user" {
  description = "Username for SSH to reverseproxy host"
  default = "root"
}

variable "ssh_private_key" {
  description = "Location of private key file for SSH access to reverseproxy host"
  default = "~/.ssh/id_rsa"
}

variable "bastion_host" {
  description = "Bastion host used to access reverse proxy"
}

variable "environment" {
  description = "Environment identifier for the rancher hosts"
  default = "default"
}

variable "hostnames" {
  type = "list"
  description = "Hostname to configure in virtual host"
}

variable "target_type" {
  description = "Indicates the type of vhost configuration to use"
}

variable "target_hosts" {
  type = "list"
  description = "List of target hosts for vhost configuration"
}

variable "ssl_enabled" {
  description = "Enable SSL with Let's Encrypt"
}

variable "letsencrypt_email" {
  description = "Email address to register with Letsencrypt"
}

variable "error_bg_image" {
  description = "Path to background image used for error pages"
}

variable "locations_config" {
  description = "A file containing NGINX location directives"
}

variable "static_host" {
  description = "A static site for redirection of requests"
  default = ""
}

locals {
  uuid = "${var.environment}-${substr(sha256(var.hostnames[0]), -10, -1)}"
}
