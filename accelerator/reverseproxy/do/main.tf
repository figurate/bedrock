provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_tag" "reverseproxy" {
  name = "reverseproxy"
}

resource "digitalocean_droplet" "reverseproxy" {
  count = "${var.enabled}"
  image = "${var.reverseproxy_image}"
  name = "reverseproxy.${var.environment}"
  region = "${var.do_region}"
  size = "s-1vcpu-1gb"
  private_networking = true
  monitoring = true
  tags = ["${digitalocean_tag.reverseproxy.name}"]
  ssh_keys = ["${var.ssh_key}"]
}
