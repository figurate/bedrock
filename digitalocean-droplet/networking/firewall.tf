module "firewall" {
  source = "figurate/firewall/digitalocean"
  count = length(var.firewalls)

  name = var.firewalls[count.index][0]
  ingress_rules = var.firewalls[count.index][1]
  egress_rules = var.firewalls[count.index][2]
}
