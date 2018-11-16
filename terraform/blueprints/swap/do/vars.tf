variable "ssh_private_key" {
  description = "Location of private key file for SSH access to droplets"
  default = "~/.ssh/id_rsa"
}

variable "bastion_private_key" {
  description = "Location of private key file for SSH access to bastion host"
  default = "~/.ssh/id_rsa"
}

variable "bastion_host" {
  description = "Bastion host used to access reverse proxy"
}

variable "target_host" {
  description = "The target host for the remote execution"
}
