//resource "digitalocean_firewall" "dns" {
//  name = "dns"
//
//  tags = [
//    "${digitalocean_tag.rancher_server.id}",
//    "${digitalocean_tag.rancher_agent.id}",
//    "${digitalocean_tag.reverse_proxy.id}"
//  ]
//
//  outbound_rule = [
//    {
//      protocol                = "tcp"
//      port_range              = "53"
//      destination_addresses   = ["0.0.0.0/0", "::/0"]
//    },
//    {
//      protocol                = "udp"
//      port_range              = "53"
//      destination_addresses   = ["0.0.0.0/0", "::/0"]
//    },
//  ]
//}
//
//resource "digitalocean_firewall" "ntp" {
//  name = "ntp"
//
//  tags = [
//    "${digitalocean_tag.rancher_server.id}",
//    "${digitalocean_tag.rancher_agent.id}",
//    "${digitalocean_tag.reverse_proxy.id}"
//  ]
//
//  outbound_rule = [
//    {
//      protocol                = "udp"
//      port_range              = "123"
//      destination_addresses   = ["0.0.0.0/0", "::/0"]
//    },
//  ]
//}
//
//resource "digitalocean_firewall" "papertrail" {
//  name = "papertrail"
//
//  tags = [
//    "${digitalocean_tag.rancher_server.id}",
//    "${digitalocean_tag.rancher_agent.id}",
//    "${digitalocean_tag.reverse_proxy.id}"
//  ]
//
//  outbound_rule = [
//    {
//      protocol                = "tcp"
//      port_range              = "51501"
//      destination_addresses   = ["0.0.0.0/0", "::/0"]
//    },
//    {
//      protocol                = "udp"
//      port_range              = "51501"
//      destination_addresses   = ["0.0.0.0/0", "::/0"]
//    },
//  ]
//}
//
//resource "digitalocean_firewall" "ssh" {
//  name = "ssh"
//
//  tags = [
//    "${digitalocean_tag.rancher_server.id}",
//    "${digitalocean_tag.rancher_agent.id}",
//    "${digitalocean_tag.reverse_proxy.id}"
//  ]
//
//  inbound_rule = [
//    {
//      protocol           = "tcp"
//      port_range         = "22"
//      source_addresses   = ["0.0.0.0/0", "::/0"]
//    },
//  ]
//}
//
//resource "digitalocean_firewall" "hkp" {
//  name = "hkp"
//
//  tags = [
//    "${digitalocean_tag.rancher_server.id}",
//    "${digitalocean_tag.rancher_agent.id}",
//    "${digitalocean_tag.reverse_proxy.id}"
//  ]
//
//  inbound_rule = [
//    {
//      protocol           = "tcp"
//      port_range         = "11371"
//      source_addresses   = ["0.0.0.0/0", "::/0"]
//    },
//  ]
//}

resource "digitalocean_firewall" "rancher_server" {
  name = "rancher-server"

  tags = ["${digitalocean_tag.rancher_server.id}"]

  inbound_rule = [
    {
      protocol           = "udp"
      port_range         = "4500"
      source_tags        = ["${digitalocean_tag.rancher_agent.id}"]
    },
    {
      protocol           = "udp"
      port_range         = "500"
      source_tags        = ["${digitalocean_tag.rancher_agent.id}"]
    },
    {
      protocol           = "tcp"
      port_range         = "443"
      source_tags        = ["${digitalocean_tag.reverse_proxy.id}"]
    },
    {
      protocol           = "tcp"
      port_range         = "80"
      source_tags        = ["${digitalocean_tag.reverse_proxy.id}"]
    },
    {
      protocol           = "tcp"
      port_range         = "8080"
      source_tags        = ["${digitalocean_tag.reverse_proxy.id}", "${digitalocean_tag.rancher_agent.id}"]
    },
  ]

  outbound_rule = [
    {
      protocol           = "udp"
      port_range         = "4500"
      destination_tags        = ["${digitalocean_tag.rancher_agent.id}"]
    },
    {
      protocol           = "udp"
      port_range         = "500"
      destination_tags        = ["${digitalocean_tag.rancher_agent.id}"]
    },
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

resource "digitalocean_firewall" "rancher_agent" {
  name = "rancher-agent"

  tags = ["${digitalocean_tag.rancher_agent.id}"]

  inbound_rule = [
    {
      protocol           = "udp"
      port_range         = "4500"
      source_tags        = ["${digitalocean_tag.rancher_server.id}"]
    },
    {
      protocol           = "udp"
      port_range         = "500"
      source_tags        = ["${digitalocean_tag.rancher_server.id}"]
    },
    {
      protocol           = "tcp"
      port_range         = "443"
      source_tags        = ["${digitalocean_tag.reverse_proxy.id}"]
    },
    {
      protocol           = "tcp"
      port_range         = "80"
      source_tags        = ["${digitalocean_tag.reverse_proxy.id}"]
    },
  ]

  outbound_rule = [
    {
      protocol           = "udp"
      port_range         = "4500"
      destination_tags        = ["${digitalocean_tag.rancher_server.id}"]
    },
    {
      protocol           = "udp"
      port_range         = "500"
      destination_tags        = ["${digitalocean_tag.rancher_server.id}"]
    },
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
    {
      protocol                = "tcp"
      port_range              = "8080"
      destination_tags        = ["${digitalocean_tag.rancher_server.id}"]
    },
  ]
}

//resource "digitalocean_firewall" "reverse_proxy" {
//  name = "reverse-proxy"
//
//  tags = ["${digitalocean_tag.reverse_proxy.id}"]
//
//  inbound_rule = [
//    {
//      protocol           = "tcp"
//      port_range         = "443"
//      source_addresses   = ["0.0.0.0/0", "::/0"]
//    },
//    {
//      protocol           = "tcp"
//      port_range         = "80"
//      source_addresses   = ["0.0.0.0/0", "::/0"]
//    },
//  ]
//
//  outbound_rule = [
//    {
//      protocol                = "tcp"
//      port_range              = "443"
//      destination_addresses   = ["0.0.0.0/0", "::/0"]
//    },
//    {
//      protocol                = "tcp"
//      port_range              = "80"
//      destination_addresses   = ["0.0.0.0/0", "::/0"]
//    },
//    {
//      protocol                = "tcp"
//      port_range              = "8080"
//      destination_tags        = ["${digitalocean_tag.rancher_server.id}"]
//    },
//  ]
//}