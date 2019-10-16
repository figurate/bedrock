output "bastion_ip" {
  description = "IP address for bastion droplet"
  value       = digitalocean_droplet.bastion.*.ipv4_address
}

output "monthly_cost" {
  description = "Monthly cost for bastion droplet"
  value       = digitalocean_droplet.bastion.*.price_monthly
}

output "enabled" {
  description = "Start/stop the bastion host"
  value       = var.enabled
}
