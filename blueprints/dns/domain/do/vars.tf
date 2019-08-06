variable "do_region" {
  description = "Digital Ocean region"
}

variable "apex_domain" {
  description = "The root domain name to provision"
}

variable "apex_target" {
  description = "IP address to associate with apex domain (leave blank to provision floating IP"
  default     = ""
}

variable "aliases" {
  description = "Additional FQDNs that are aliases of the apex domain"
  type        = "list"
  default     = []
}

variable "record_ttl" {
  description = "The time to live (TTL) in seconds"
  default     = "900"
}
