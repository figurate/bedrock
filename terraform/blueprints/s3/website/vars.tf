variable "fqdn" {
  description = "Website domain"
}

variable "version_enabled" {
  description = "Enable object versioning"
  default = "true"
}

variable "object_expiration" {
  description = "Configure expiry of old verions (days)"
  default = "90"
}

variable "source_cidrs" {
  description = "Restrict site access to the specified CIDR blocks of IP addresses"
  type = "list"
  default = ["0.0.0.0/0"]
}

variable "access_log_bucket" {
  description = "An S3 bucket used as a target for access logs"
  default = ""
}

variable "index_page" {
  description = "HTML index page"
  default = "index.html"
}

variable "error_page" {
  description = "HTML error page"
  default = "error.html"
}

variable "routing_rules" {
  default = ""
}

variable "content_path" {
  description = "Root path of local website content"
  default = "."
}

variable "includes" {
  description = "A list of include filters to apply"
  type = "list"
  default = []
}

variable "excludes" {
  description = "A list of exclude filters to apply"
  type = "list"
  default = ["*"]
}

variable "delete" {
  description = "Remove files from the destination that don't exist in the source"
  default = "false"
}

variable "create_route53_record" {
  description = "Boolean value to indicate whether route53 record is created"
  default = "true"
}

locals {
  excludes_string = "--exclude \"${join("\" --exclude \"", var.excludes)}\""
  includes_string = "--include \"${join("\" --include \"", var.includes)}\""
  hosted_zone = "${join(".", slice(split(".", var.fqdn), 1, length(split(".", var.fqdn))))}"
}
