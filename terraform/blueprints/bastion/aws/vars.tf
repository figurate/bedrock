variable "bastion_user" {
  description = "Username for bastion SSH user"
}

variable "ssh_key" {
  description = "Location of public key file for SSH access to droplets"
}

variable "bastion_image" {
  description = "AWS image for bastion instance"
  default = "ami-00e17d1165b9dd3ec"
}

variable "instance_type" {
  description = "AWS instance type for bastion"
  default = "t2.micro"
}

variable "enabled" {
  description = "Start/stop the bastion host"
}
