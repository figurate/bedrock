variable "vpc_default" {
  description = "Boolean value to indicate whether the matched VPC should be default for the region"
  default     = "true"
}

variable "vpc_tags" {
  type        = "map"
  description = "A map of tags to match on the VPC lookup"
  default     = {}
}

variable "fqdn" {
  description = "A fully qualified domain name (FQDN) that is the basis for the hosted zone"
}

variable "vpc_id" {
  description = "Identifier of VPC to associated private zone with (leave blank to indicate default VPC)"
  default     = ""
}
