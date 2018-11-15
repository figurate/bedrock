/**
 * # Digital Ocean Bastion host configuration
 *
 * Provision a droplet with SSH ingress authenticated with the specified public key.
 */
provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_tag" "bastion" {
  name = "${local.uuid}"
}

resource "digitalocean_droplet" "bastion" {
  count = "${var.enabled}"
  image = "${var.bastion_image}"
  name = "${local.uuid}"
  region = "${var.do_region}"
  size = "s-1vcpu-1gb"
  private_networking = true
  monitoring = true
  tags = ["${digitalocean_tag.bastion.name}"]
  ssh_keys = ["${var.ssh_key}"]
  user_data = <<EOF
#cloud-config
packages:
  - fail2ban
  - unattended-upgrades
  - ntpdate

timezone: Australia/Melbourne

ntp:
  enabled: true
  servers:
    - 0.au.pool.ntp.org
    - 1.au.pool.ntp.org
    - 2.au.pool.ntp.org
    - 3.au.pool.ntp.org

runcmd:
  - printf '\nClientAliveInterval 100\nClientAliveCountMax 0' >> /etc/ssh/sshd_config
  - service ssh restart
EOF
}

resource "null_resource" "bastion_ssh_key" {
  depends_on = ["digitalocean_droplet.bastion"]

  provisioner "local-exec" {
    command = "scp ${var.ssh_private_key} root@${digitalocean_droplet.bastion.ipv4_address}:/root/.ssh"
  }

  provisioner "remote-exec" {
    inline = ["chmod 600 /root/.ssh/id_rsa"]
    connection {
      type     = "ssh"
      user     = "root"
      host = "${digitalocean_droplet.bastion.ipv4_address}"
      private_key = "${file(var.ssh_private_key)}"
    }
  }
}
