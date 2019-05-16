variable "cloudformation_path" {
  description = "The root path to cloudformation templates"
  default = "cloudformation"
}

variable "service_name" {
  description = "Name of the ECS service"
}

variable "cluster_name" {
  description = "Name of the ECS cluster"
}

locals {
  env_string = ""
}
