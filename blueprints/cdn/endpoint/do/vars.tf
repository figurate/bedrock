variable "bucket_name" {
  description = "Name of Spaces bucket"
}

variable "do_region" {
  description = "Digital Ocean region"
}

variable "alias_domain" {
  description = "The root domain for the aliases"
}

variable "aliases" {
  type        = "list"
  description = "A list of associated domain records that alias the CDN endpoint"
  default     = []
}

variable "record_ttl" {
  description = "The time to live (TTL) in seconds"
  default     = "900"
}
