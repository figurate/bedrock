variable "cloudformation_path" {
  description = "The root path to cloudformation templates"
  default = "cloudformation"
}

variable "environment" {
  description = "The name of the environment represented by the VPC"
}

variable "cidr_block" {
  description = "The CIDR block covered by the VPC. For example: 10.0.0.0/16"
}
