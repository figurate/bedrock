provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_ssh_key" "do_ssh_key" {
  name = "ssh-key"
  public_key = "${file(var.ssh_key)}"
}

resource "digitalocean_tag" "bastion" {
  name = "bastion"
}

resource "digitalocean_droplet" "bastion" {
  count = "${var.enabled}"
  image = "${var.bastion_image}"
  name = "bastion"
  region = "${var.do_region}"
  size = "s-1vcpu-1gb"
  private_networking = true
  monitoring = true
  tags = ["${digitalocean_tag.bastion.name}"]
  ssh_keys = ["${digitalocean_ssh_key.do_ssh_key.id}"]
}
