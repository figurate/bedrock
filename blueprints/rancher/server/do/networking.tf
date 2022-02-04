resource "digitalocean_firewall" "default" {
  name = "${local.uuid}"

  tags = [
    "${digitalocean_tag.rancherserver.id}",
    "${digitalocean_tag.rancheragent.id}",
  ]

  inbound_rule {
    protocol    = "tcp"
    port_range  = "22"
    source_tags = ["bastion"]
  }

  outbound_rule = [
    {
      protocol              = "tcp"
      port_range            = "80"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "tcp"
      port_range            = "443"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "tcp"
      port_range            = "53"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "udp"
      port_range            = "53"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "udp"
      port_range            = "123"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]
}

resource "digitalocean_firewall" "papertrail" {
  name = "${local.uuid}-papertrail"

  tags = [
    "${digitalocean_tag.rancherserver.id}",
    "${digitalocean_tag.rancheragent.id}",
  ]

  outbound_rule = [
    {
      protocol              = "tcp"
      port_range            = "51501"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "udp"
      port_range            = "51501"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
  ]
}

resource "digitalocean_firewall" "rancherserver" {
  name = "${local.uuid}-rancherserver"

  tags = ["${digitalocean_tag.rancherserver.id}"]

  inbound_rule = [
    {
      protocol    = "udp"
      port_range  = "4500"
      source_tags = ["${digitalocean_tag.rancheragent.id}"]
    },
    {
      protocol    = "udp"
      port_range  = "500"
      source_tags = ["${digitalocean_tag.rancheragent.id}"]
    },
    {
      protocol    = "tcp"
      port_range  = "8080"
      source_tags = ["reverseproxy", "${digitalocean_tag.rancheragent.id}"]
    },
  ]

  outbound_rule = [
    {
      protocol         = "tcp"
      port_range       = "22"
      destination_tags = ["${digitalocean_tag.rancheragent.id}"]
    },
    {
      protocol         = "tcp"
      port_range       = "2376"
      destination_tags = ["${digitalocean_tag.rancheragent.id}"]
    },
    {
      protocol         = "tcp"
      port_range       = "8080"
      destination_tags = ["${digitalocean_tag.rancheragent.id}"]
    },
  ]
}

resource "digitalocean_firewall" "rancheragent" {
  name = "${local.uuid}-rancheragent"

  tags = ["${digitalocean_tag.rancheragent.id}"]

  inbound_rule = [
    {
      protocol    = "tcp"
      port_range  = "22"
      source_tags = ["${digitalocean_tag.rancherserver.id}"]
    },
    {
      protocol    = "tcp"
      port_range  = "2376"
      source_tags = ["${digitalocean_tag.rancherserver.id}"]
    },
    {
      protocol   = "udp"
      port_range = "4500"
      source_tags = [
        "${digitalocean_tag.rancherserver.id}",
        "${digitalocean_tag.rancheragent.id}"
      ]
    },
    {
      protocol   = "udp"
      port_range = "500"
      source_tags = [
        "${digitalocean_tag.rancherserver.id}",
        "${digitalocean_tag.rancheragent.id}"
      ]
    },
    {
      protocol    = "tcp"
      port_range  = "443"
      source_tags = ["reverseproxy", "${digitalocean_tag.rancherserver.id}"]
    },
    {
      protocol    = "tcp"
      port_range  = "80"
      source_tags = ["reverseproxy", "${digitalocean_tag.rancherserver.id}"]
    },
    {
      protocol    = "tcp"
      port_range  = "8080-8082"
      source_tags = ["reverseproxy", "${digitalocean_tag.rancherserver.id}"]
    },
  ]

  outbound_rule = [
    {
      protocol   = "udp"
      port_range = "4500"
      destination_tags = [
        "${digitalocean_tag.rancherserver.id}",
        "${digitalocean_tag.rancheragent.id}"
      ]
    },
    {
      protocol   = "udp"
      port_range = "500"
      destination_tags = [
        "${digitalocean_tag.rancherserver.id}",
        "${digitalocean_tag.rancheragent.id}"
      ]
    },
    {
      protocol         = "tcp"
      port_range       = "8080"
      destination_tags = ["${digitalocean_tag.rancherserver.id}"]
    },
  ]
}