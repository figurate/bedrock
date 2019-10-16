/**
 * # Digital Ocean Rancher host configuration
 *
 * Provision a droplet with Rancher server.
 */
data "template_file" "userdata" {
  template = file(format("%s/%s.yml", var.template_path, var.image_os))
  vars = {
    AuthorizedUserName   = var.ssh_user
    AuthorizedUserSSHKey = var.ssh_key
    PapertrailHost       = var.papertrail_host
    PapertrailPort       = var.papertrail_port
  }
}

resource "digitalocean_tag" "rancherserver" {
  name = "rancherserver"
}

resource "digitalocean_tag" "rancheragent" {
  name = "rancheragent"
}

resource "digitalocean_droplet" "rancherserver" {
  count              = var.enabled
  image              = var.rancher_image
  name               = "${var.environment}-rancherserver.${var.apex_domain}"
  region             = var.do_region
  size               = "s-1vcpu-2gb"
  private_networking = true
  monitoring         = true
  //  volume_ids = ["${digitalocean_volume.rancher_data.id}"]
  tags = [
  digitalocean_tag.rancherserver.name]
  //  ssh_keys = ["${var.ssh_key}"]
  //  depends_on = ["digitalocean_volume.rancher_data"]
  user_data = data.template_file.userdata.rendered
}

//resource "digitalocean_volume" "rancher_data" {
//  name = "rancher-data.${var.environment}"
//  region = "${var.do_region}"
//  size = 50
//}

resource "digitalocean_floating_ip_assignment" "rancherserver" {
  count      = length(var.floatingip_addresses)
  droplet_id = digitalocean_droplet.rancherserver[count.index].id
  ip_address = var.floatingip_addresses[count.index]
}
