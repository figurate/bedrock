variable "fqdn" {
  description = "Fully-qualified domain name for the record"
}

variable "record_type" {
  description = "Indicates the type of DNS record (A, CNAME, etc.)"
  default = "A"
}

variable "record_ttl" {
  description = "The time to live (TTL) in seconds"
  default = "900"
}

variable "targets" {
  description = "A list of target values for the DNS record"
  type = "list"
}

locals {
  hosted_zone = "${join(".", slice(split(".", var.fqdn), 1, length(split(".", var.fqdn))))}"
}