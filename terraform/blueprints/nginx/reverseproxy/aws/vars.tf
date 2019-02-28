variable "cloudformation_path" {
  description = "The root path to cloudformation templates"
  default = "cloudformation"
}

variable "userdata_path" {
  description = "The root path to userdata templates"
  default = "userdata"
}

variable "environment" {
  description = "The name of the environment associated with the reverse proxy"
}

variable "image_name" {
  description = "AWS image for autoscaling launch configuration"
  default = "amzn2-ami-hvm-*"
//  default = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
}

variable "image_owner" {
  description = "AMI image owner (leave blank for current account)"
  default = "137112412989"
  // Canonical
//  default = "679593333241"
}

variable "image_os" {
  description = <<EOF
The operating system installed on the selected AMI. Valid values are:

  * al2     = Amazon Linux 2
  * ubuntu  = Ubuntu
EOF
  default = "al2"
}

variable "instance_type" {
  description = "AWS instance type for launch configuration"
  default = "t3.nano"
}

variable "amplify_key" {
  description = "API key for nginx amplify"
}

variable "papertrail_host" {
  description = "Target URL for Papertrail logs"
}

variable "papertrail_port" {
  description = "Target port for Papertrail logs"
}
