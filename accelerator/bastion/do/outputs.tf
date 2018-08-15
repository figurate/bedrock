output "do_token" {
  description = "Digital Ocean API token"
  value = "${var.do_token}"
  sensitive = true
}

output "do_region" {
  description = "Digital Ocean region"
  value = "${var.do_region}"
}

output "ssh_key" {
  description = "Location of public key file for SSH access to droplets"
  value = "${var.ssh_key}"
}

output "ssh_key_name" {
  description = "Name of key for SSH access to droplets"
  value = "${var.ssh_key_name}"
}

output "bastion_image" {
  description = "Digital Ocean image for bastion droplet"
  value = "${var.bastion_image}"
}

output "enabled" {
  description = "Start/stop the bastion host"
  value = "${var.enabled}"
}