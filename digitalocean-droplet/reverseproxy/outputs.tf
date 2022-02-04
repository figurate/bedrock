output "reverseproxy_ip" {
  description = "IP address for reverseproxy droplet"
  value       = digitalocean_droplet.reverseproxy.*.ipv4_address
}

output "reverseproxy_ip_private" {
  description = "Private IP address for reverseproxy droplet"
  value       = digitalocean_droplet.reverseproxy.*.ipv4_address_private
}
