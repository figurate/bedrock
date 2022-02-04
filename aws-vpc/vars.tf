variable "vpc_default" {
  description = "Indicates if the default VPC should be used"
  default = true
}

variable "vpc_tags" {
  description = "A map of tags to apply to a non-default application VPC"
  default = {}
}

variable "vpc_cidr" {
  description = "CIDR block for a non-default application VPC"
  default = null
}
