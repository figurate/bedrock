output "do_token" {
  description = "Digital Ocean API token"
  value = "${var.do_token}"
  sensitive = true
}

output "do_region" {
  description = "Digital Ocean region"
  value = "${digitalocean_droplet.bastion.*.region}"
}

output "bastion_image" {
  description = "Digital Ocean image for bastion droplet"
  value = "${digitalocean_droplet.bastion.*.image}"
}

output "monthly_cost" {
  description = "Monthly cost for bastion droplet"
  value = "${digitalocean_droplet.bastion.*.price_monthly}"
}

output "ssh_key" {
  description = "Name of key for SSH access to droplets"
  value = "${var.ssh_key}"
}

output "enabled" {
  description = "Start/stop the bastion host"
  value = "${var.enabled}"
}