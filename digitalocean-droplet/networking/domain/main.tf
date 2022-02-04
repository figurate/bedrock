/**
 * Creates a DNS root domain.
 */
resource "digitalocean_floating_ip" apex_target {
  count  = var.apex_target == "" ? 1 : 0
  region = var.do_region
}

resource "digitalocean_domain" domain {
  name       = var.apex_domain
  ip_address = var.apex_target != "" ? var.apex_target : digitalocean_floating_ip.apex_target[0].ip_address
}

resource "digitalocean_record" record {
  count  = length(var.aliases)
  domain = digitalocean_domain.domain.name
  name   = var.aliases[count.index]
  type   = "CNAME"
  ttl    = var.record_ttl
  value  = "${digitalocean_domain.domain.name}."
}
