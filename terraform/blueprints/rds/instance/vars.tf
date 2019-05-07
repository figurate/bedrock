variable "cloudformation_path" {
  description = "The root path to cloudformation templates"
  default = "cloudformation"
}

variable "environment" {
  description = "The name of the environment applied to the RDS stack"
}
