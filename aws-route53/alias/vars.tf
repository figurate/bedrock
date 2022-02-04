variable "fqdn" {
  description = "Fully-qualified domain name for the record"
}

variable "record_type" {
  description = "Indicates the type of DNS record (A, CNAME, etc.)"
  default     = "A"
}

variable "target" {
  description = "An alias target for the DNS record"
}

locals {
  hosted_zone = join(".", slice(split(".", var.fqdn), 1, length(split(".", var.fqdn))))
}