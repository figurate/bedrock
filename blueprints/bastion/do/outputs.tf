output "bastion_ip" {
  description = "IP address for bastion droplet"
  value       = "${digitalocean_droplet.bastion.*.ipv4_address}"
}

output "monthly_cost" {
  description = "Monthly cost for bastion droplet"
  value       = "${digitalocean_droplet.bastion.*.price_monthly}"
}

output "ssh_key" {
  description = "Name of key for SSH access to droplets"
  value       = "${var.ssh_key}"
}

output "enabled" {
  description = "Start/stop the bastion host"
  value       = "${var.enabled}"
}
