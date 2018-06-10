data "digitalocean_image" "puppet-image" {
  name = "${var.do_image}"
}

resource "digitalocean_ssh_key" "do_ssh_key" {
  name = "ssh-key"
  public_key = "${file(var.ssh_key)}"
}

resource "digitalocean_tag" "rancher_server" {
  name = "rancher-server"
}

resource "digitalocean_tag" "rancher_agent" {
  name = "rancher-agent"
}

resource "digitalocean_tag" "reverse_proxy" {
  name = "reverse-proxy"
}

resource "digitalocean_droplet" "rancherserver" {
  image = "${data.digitalocean_image.puppet-image.image}"
  name = "rancherserver.${var.environment}"
  region = "${var.do_region}"
  size = "s-1vcpu-2gb"
  private_networking = true
  monitoring = true
  volume_ids = ["${digitalocean_volume.rancher_data.id}"]
  tags = ["${digitalocean_tag.rancher_server.name}"]
  ssh_keys = ["${digitalocean_ssh_key.do_ssh_key.id}"]
  depends_on = ["digitalocean_volume.rancher_data"]
  user_data = <<EOF
#cloud-config
write_files:
  - path: /opt/puppetlabs/facter/facts.d/environment.yaml
    content: |
      environment: ${var.environment}
EOF
}

resource "digitalocean_droplet" "rancheragent" {
  count = 2
  image = "${data.digitalocean_image.puppet-image.image}"
  name = "rancheragent-${count.index}.${var.environment}"
  region = "${var.do_region}"
  size = "s-1vcpu-1gb"
  private_networking = true
  monitoring = true
  tags = ["${digitalocean_tag.rancher_agent.name}"]
  ssh_keys = ["${digitalocean_ssh_key.do_ssh_key.id}"]
  user_data = <<EOF
#cloud-config
write_files:
  - path: /opt/puppetlabs/facter/facts.d/hosts.yaml
    content: |
      host_rancher: ${digitalocean_droplet.rancherserver.ipv4_address_private}
  - path: /opt/puppetlabs/facter/facts.d/environment.yaml
    content: |
      environment: ${var.environment}
      group: rancheragent
EOF
  depends_on = ["digitalocean_droplet.rancherserver"]
}

resource "digitalocean_droplet" "reverse_proxy" {
  image = "${data.digitalocean_image.puppet-image.image}"
  name = "reverseproxy.${var.environment}"
  region = "${var.do_region}"
  size = "s-1vcpu-1gb"
  private_networking = true
  monitoring = true
  tags = ["${digitalocean_tag.reverse_proxy.name}"]
  ssh_keys = ["${digitalocean_ssh_key.do_ssh_key.id}"]
  user_data = <<EOF
#cloud-config
write_files:
  - path: /opt/puppetlabs/facter/facts.d/hosts.yaml
    content: |
      host_rancher: ${digitalocean_droplet.rancherserver.ipv4_address_private}
      host_wnews: ${digitalocean_droplet.rancheragent.*.ipv4_address_private[0]}
      host_tzurl: ${digitalocean_droplet.rancheragent.*.ipv4_address_private[0]}
  - path: /opt/puppetlabs/facter/facts.d/environment.yaml
    content: |
      environment: ${var.environment}
      group: rancheragent
EOF
  depends_on = ["digitalocean_droplet.rancherserver", "digitalocean_droplet.rancheragent"]
}

resource "digitalocean_volume" "rancher_data" {
  name = "rancher-data.${var.environment}"
  region = "${var.do_region}"
  size = 50
}
