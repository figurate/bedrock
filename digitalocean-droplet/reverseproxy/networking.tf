resource "digitalocean_firewall" "ssh" {
  name = "${local.uuid}-ssh"
  tags = [digitalocean_tag.reverseproxy.id]
  inbound_rule {
    protocol    = "tcp"
    port_range  = "22"
    source_tags = ["bastion"]
  }
}

resource "digitalocean_firewall" http {
  name = "${local.uuid}-http"
  tags = [digitalocean_tag.reverseproxy.id]
  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "tcp"
    port_range            = "80"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "tcp"
    port_range            = "443"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_firewall" dns {
  name = "${local.uuid}-dns"
  tags = [digitalocean_tag.reverseproxy.id]
  outbound_rule {
    protocol              = "tcp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_firewall" ntp {
  name = "${local.uuid}-ntp"
  tags = [digitalocean_tag.reverseproxy.id]
  outbound_rule {
    protocol              = "udp"
    port_range            = "123"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_firewall" "papertrail" {
  count = var.papertrail_host != "" ? 1 : 0
  name  = "${local.uuid}-papertrail"
  tags  = [digitalocean_tag.reverseproxy.id]
  outbound_rule {
    protocol              = "tcp"
    port_range            = var.papertrail_port
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = var.papertrail_port
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_firewall" "upstream" {
  count = length(var.upstream_ports)
  name  = "${local.uuid}-upstream-${count.index}"
  tags  = [digitalocean_tag.reverseproxy.id]
  outbound_rule {
    protocol              = "tcp"
    port_range            = var.upstream_ports[count.index]
    destination_tags      = var.upstream_tags
    destination_addresses = var.upstream_addresses
  }
}