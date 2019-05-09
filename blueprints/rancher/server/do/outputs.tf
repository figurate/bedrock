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

output "enabled" {
  description = "Start/stop the rancher host"
  value = "${var.enabled}"
}

output "rancherserver_ip" {
  value = "${digitalocean_droplet.rancherserver.*.ipv4_address}"
}
