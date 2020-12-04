variable "name" {
  description = "Namespace name"
}

variable "public_zone" {
  description = "Name of the public zone for this namespace"
}

variable "private_zone" {
  description = "Name of the private zone for this namespace"
}

variable "vpc" {
  description = "VPC identifer for private DNS"
}
