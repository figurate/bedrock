variable "vpc_default" {
  description = "Boolean value to indicate whether the matched VPC should be default for the region"
  default = "true"
}

variable "vpc_tags" {
  type        = "map"
  description = "A map of tags to match on the VPC lookup"
  default     = {}
}

variable "cidr_prefix" {
  description = "The CIDR block"
}

variable "is_public" {
  description = "Indicates whether the subnets should be publically routable (via Internet)"
  default = false
}

variable "newbits" {
  description = <<EOF
The bits added to the cidr block to define the extent of subnets. Note this cannot exceed (24 - cidr_range)

Example:

 * CIDR = 10.0.0.1/16
 * 0 < Newbits <= 8
EOF
}

variable "route_table" {
  description = "Route table to associate with subnets"
}
