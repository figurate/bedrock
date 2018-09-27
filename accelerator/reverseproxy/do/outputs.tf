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

output "reverseproxy_ip" {
  description = "IP address for reverseproxy droplet"
  value = "${digitalocean_droplet.reverseproxy.*.ipv4_address}"
}

output "reverseproxy_ip_private" {
  description = "Private IP address for reverseproxy droplet"
  value = "${digitalocean_droplet.reverseproxy.*.ipv4_address_private}"
}

output "floating_ip" {
  description = "Floating IP address for reverseproxy droplet"
  value = "${digitalocean_floating_ip.reverseproxy.ip_address}"
}

output "enabled" {
  description = "Start/stop the reverseproxy host"
  value = "${var.enabled}"
}