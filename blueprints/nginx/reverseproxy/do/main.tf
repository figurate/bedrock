/**
 * # Digital Ocean Reverse Proxy host configuration
 *
 * Provision a droplet with NGINX and letsencrypt installed.
 */
data digitalocean_ssh_key ssh_key {
  name = var.ssh_key
}

data "template_file" "userdata" {
  template = file(format("%s/%s.yml", var.template_path, var.image_os))
  vars = {
    NginxAmplifyKey      = var.amplify_key
    NginxHostname        = "${var.environment}-reverseproxy"
    AuthorizedUserName   = var.ssh_user
    AuthorizedUserSSHKey = data.digitalocean_ssh_key.ssh_key.public_key
    PapertrailHost       = var.papertrail_host
    PapertrailPort       = var.papertrail_port
  }
}

resource "digitalocean_tag" "reverseproxy" {
  name = "reverseproxy"
}

resource "digitalocean_droplet" "reverseproxy" {
  count              = var.instance_count
  image              = var.droplet_image
  name               = "${var.environment}${count.index + 1}-reverseproxy.${var.apex_domain}"
  region             = var.do_region
  size               = "s-1vcpu-1gb"
  private_networking = true
  monitoring         = true
  tags               = [digitalocean_tag.reverseproxy.name]
  ssh_keys           = [data.digitalocean_ssh_key.ssh_key.fingerprint]
  user_data          = data.template_file.userdata.rendered
}

resource "digitalocean_floating_ip_assignment" "reverseproxy" {
  count      = length(var.floatingip_addresses)
  droplet_id = digitalocean_droplet.reverseproxy[count.index].id
  ip_address = var.floatingip_addresses[count.index]
}
