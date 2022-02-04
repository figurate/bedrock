variable "cloudformation_path" {
  description = "The root path to cloudformation templates"
  default = "cloudformation"
}

variable "image_name" {
  description = "AWS image for spotfleet launch specification"
  default = "amzn2-ami-hvm-2.0.????????-x86_64-gp2"
}

variable "image_owner" {
  description = "AMI image owner (leave blank for current account)"
  default = "137112412989"
}

variable "instance_type" {
  description = "AWS instance type for launch specification"
  default = "t2.micro"
}
