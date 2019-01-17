resource "digitalocean_firewall" "default" {
  name = "${local.uuid}"

  tags = [
    "${digitalocean_tag.reverseproxy.id}",
  ]

  inbound_rule {
    protocol           = "tcp"
    port_range         = "22"
    source_tags   = ["bastion"]
  }

  outbound_rule = [
    {
      protocol = "tcp"
      port_range = "80"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol = "tcp"
      port_range = "443"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol                = "tcp"
      port_range              = "53"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol                = "udp"
      port_range              = "53"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol                = "udp"
      port_range              = "123"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    },
  ]
}

resource "digitalocean_firewall" "papertrail" {
  name = "${local.uuid}-papertrail"

  tags = [
    "${digitalocean_tag.reverseproxy.id}",
  ]

  outbound_rule = [
    {
      protocol                = "tcp"
      port_range              = "51501"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol                = "udp"
      port_range              = "51501"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    },
  ]
}

resource "digitalocean_firewall" "reverseproxy" {
  name = "${local.uuid}-reverseproxy"

  tags = [
    "${digitalocean_tag.reverseproxy.id}",
  ]

  inbound_rule = [
    {
      protocol           = "tcp"
      port_range         = "443"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol           = "tcp"
      port_range         = "80"
      source_addresses   = ["0.0.0.0/0", "::/0"]
    },
  ]

  outbound_rule {
    protocol = "tcp"
    port_range = "8080"
    destination_tags = ["rancherserver"]
  }
}

resource "digitalocean_firewall" "reverseproxy_upstream" {
  name = "${local.uuid}-upstream-${count.index}"
  count = "${length(var.upstream_ports)}"

  tags = [
    "${digitalocean_tag.reverseproxy.id}",
  ]

  outbound_rule {
    protocol = "tcp"
    port_range = "${var.upstream_ports[count.index]}"
    destination_tags = ["rancheragent"]
  }
}