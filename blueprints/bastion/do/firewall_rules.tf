resource "digitalocean_firewall" "default" {
  name = "${local.uuid}"

  tags = [
    "${digitalocean_tag.bastion.id}",
  ]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule = [
    {
      protocol              = "tcp"
      port_range            = "22"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
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
    "${digitalocean_tag.bastion.id}",
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
