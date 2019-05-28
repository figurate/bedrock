variable "userdata_path" {
  description = "The root path to userdata templates"
  default     = "userdata"
}

variable "vpc_default" {
  description = "Boolean value to indicate whether the matched VPC should be default for the region"
  default     = "true"
}

variable "vpc_tags" {
  type        = "list"
  description = "A list of tags to match on the VPC lookup"
  default     = []
}

variable "bastion_user" {
  description = "Username for bastion SSH user"
}

variable "ssh_key" {
  description = "Public key file for SSH access to host"
  default     = ""
}

variable "ssh_key_file" {
  description = "Location of public key file for SSH access to droplets"
  default     = "~/.ssh/id_rsa.pub"
}

variable "image_name" {
  description = "AWS image for bastion instance"
  default     = "amzn2-ami-hvm-*"
}

variable "image_owner" {
  description = "AMI image owner (leave blank for current account)"
  default     = "137112412989"
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
  description = "AWS instance type for bastion"
  default     = "t3.nano"
}

variable "enabled" {
  description = "Start/stop the bastion host"
  default     = "true"
}

variable "shutdown_delay" {
  description = "Number of minutes before the host will automatically shutdown"
  default     = 60
}

variable "fqdn" {
  description = "Fully-qualified domain name for the record"
}

variable "record_ttl" {
  description = "The time to live (TTL) in seconds"
  default     = "300"
}

locals {
  hosted_zone = "${join(".", slice(split(".", var.fqdn), 1, length(split(".", var.fqdn))))}"
}
