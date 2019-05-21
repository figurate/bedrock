variable "vpc_default" {
  description = "Boolean value to indicate whether the matched VPC should be default for the region"
  default = "true"
}

variable "vpc_tags" {
  type = "list"
  description = "A list of tags to match on the VPC lookup"
  default = []
}

variable "subnet_filter" {
  description = "Filter the name of subnets to associate with the Security Groups"
}
