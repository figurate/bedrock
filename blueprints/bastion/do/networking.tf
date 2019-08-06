resource "digitalocean_firewall" "ssh" {
  name = "${local.uuid}-ssh"
  tags = [digitalocean_tag.bastion.id]
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_firewall" "http" {
  name = "${local.uuid}-http"
  tags = [digitalocean_tag.bastion.id]
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

resource "digitalocean_firewall" "dns" {
  name = "${local.uuid}-dns"
  tags = [digitalocean_tag.bastion.id]
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

resource "digitalocean_firewall" "ntp" {
  name = "${local.uuid}-ntp"
  tags = [digitalocean_tag.bastion.id]
  outbound_rule {
    protocol              = "udp"
    port_range            = "123"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_firewall" "papertrail" {
  name = "${local.uuid}-papertrail"
  tags = [digitalocean_tag.bastion.id]
  outbound_rule {
    protocol              = "tcp"
    port_range            = "51501"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "51501"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

resource "digitalocean_firewall" "upstream" {
  name = "${local.uuid}-upstream"
  tags = [digitalocean_tag.bastion.id]
  outbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    destination_tags = var.upstream_tags
  }
}