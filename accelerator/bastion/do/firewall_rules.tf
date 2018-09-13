resource "digitalocean_firewall" "ssh" {
  name = "${local.uuid}-ssh"

  tags = [
    "${digitalocean_tag.bastion.id}",
  ]

  inbound_rule {
    protocol           = "tcp"
    port_range         = "22"
    source_addresses   = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule = [
    {
      protocol = "tcp"
      port_range = "22"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
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
  ]
}
