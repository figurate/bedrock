variable "cloudformation_path" {
  description = "The root path to cloudformation templates"
  default = "cloudformation"
}

variable "environment" {
  description = "The name of the environment associated with the reverse proxy"
}

variable "image_name" {
  description = "AWS image for autoscaling launch configuration"
  default = "amzn2-ami-hvm-*"
}

variable "image_owner" {
  description = "AMI image owner (leave blank for current account)"
  default = "137112412989"
}

variable "instance_type" {
  description = "AWS instance type for launch configuration"
  default = "t2.micro"
}
