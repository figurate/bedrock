output "floating_ips" {
  value = digitalocean_floating_ip.apex_target.*.ip_address
}
