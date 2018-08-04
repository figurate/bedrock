resource "digitalocean_firewall" "dns" {
  name = "dns"

  tags = [
    "${digitalocean_tag.reverseproxy.id}",
  ]

  outbound_rule = [
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
  ]
}

resource "digitalocean_firewall" "ntp" {
  name = "ntp"

  tags = [
    "${digitalocean_tag.reverseproxy.id}",
  ]

  outbound_rule = [
    {
      protocol                = "udp"
      port_range              = "123"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    },
  ]
}

resource "digitalocean_firewall" "papertrail" {
  name = "papertrail"

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

resource "digitalocean_firewall" "ssh" {
  name = "ssh"

  tags = [
    "${digitalocean_tag.reverseproxy.id}",
  ]

  inbound_rule = [
    {
      protocol           = "tcp"
      port_range         = "22"
      source_tags        = ["bastion"]
    },
  ]
}

resource "digitalocean_firewall" "hkp" {
  name = "hkp"

  tags = [
    "${digitalocean_tag.reverseproxy.id}",
  ]

  outbound_rule = [
    {
      protocol           = "tcp"
      port_range         = "11371"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    },
  ]
}

resource "digitalocean_firewall" "reverse_proxy" {
  name = "reverse-proxy"

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

  outbound_rule = [
    {
      protocol                = "tcp"
      port_range              = "443"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol                = "tcp"
      port_range              = "80"
      destination_addresses   = ["0.0.0.0/0", "::/0"]
    },
  ]
}