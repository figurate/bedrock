variable "vpc_default" {
  description = "Boolean value to indicate whether the matched VPC should be default for the region"
  default = "true"
}

variable "vpc_tags" {
  type = map(any)
  description = "A map of tags to match on the VPC lookup"
  default     = {}
}

variable "proxy_id" {
  description = "Network interface of proxy used for Internet access"
}
