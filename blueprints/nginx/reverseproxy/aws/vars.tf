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

//variable "subnet" {
//  description = "The name of the VPC subnet in which to deploy the EC2 instance"
//}

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

variable "reverseproxy_user" {
  description = "Username for reverseproxy SSH user"
}

variable "ssh_key" {
  description = "Public key file for SSH access to host"
  default = ""
}

variable "ssh_key_file" {
  description = "Location of public key file for SSH access to reverseproxy"
  default = "~/.ssh/id_rsa.pub"
}

variable "public_zone" {
  description = "Hosted zone identifier for public DNS entry"
}

variable "private_zone" {
  description = "Hosted zone identifier for private DNS entry"
}
