/**
 * # Digital Ocean Reverse Proxy host configuration
 *
 * Provision a droplet with NGINX and letsencrypt installed.
 */
data "template_file" "userdata" {
  template = file(format("%s/%s.yml", var.userdata_path, var.image_os))
  vars = {
    NginxAmplifyKey = var.amplify_key
    NginxHostname = "${var.environment}-reverseproxy"
    AuthorizedUserName = "${var.reverseproxy_user}"
    AuthorizedUserSSHKey = "${file(var.ssh_key)}"
    PapertrailHost = "${var.papertrail_host}"
    PapertrailPort = "${var.papertrail_port}"
  }
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
  user_data = "${data.template_file.userdata.rendered}"
}

resource "digitalocean_floating_ip" "reverseproxy" {
  droplet_id = "${digitalocean_droplet.reverseproxy.id}"
  region     = "${digitalocean_droplet.reverseproxy.region}"
}
