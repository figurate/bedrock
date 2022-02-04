output "rancherserver_ip" {
  value = digitalocean_droplet.rancherserver.*.ipv4_address
}
