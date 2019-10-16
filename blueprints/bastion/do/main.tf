/**
 * # Digital Ocean Bastion host configuration
 *
 * Provision a droplet with SSH ingress authenticated with the specified public key.
 */
data "digitalocean_domain" apex_domain {
  name = var.apex_domain
}

data digitalocean_ssh_key ssh_key {
  name = var.ssh_key
}

data "template_file" "motd" {
  template = file(format("%s/motd.yml", var.template_path))
}

data "template_file" "userdata" {
  template = file(format("%s/%s.yml", var.template_path, var.image_os))

  vars = {
    AuthorizedUserName   = var.ssh_user
    AuthorizedUserSSHKey = data.digitalocean_ssh_key.ssh_key.public_key
    ShutdownDelay        = var.shutdown_delay
    BannerMessage        = data.template_file.motd.rendered
  }
}

resource "digitalocean_tag" "bastion" {
  name = local.uuid
}

resource "digitalocean_droplet" "bastion" {
  count              = var.enabled == "true" ? 1 : 0
  image              = var.droplet_image
  name               = "${local.uuid}.${data.digitalocean_domain.apex_domain.name}"
  region             = var.do_region
  size               = "s-1vcpu-1gb"
  private_networking = true
  monitoring         = true
  tags               = [digitalocean_tag.bastion.name]
  ssh_keys           = [data.digitalocean_ssh_key.ssh_key.fingerprint]
  user_data          = data.template_file.userdata.rendered
}

resource "digitalocean_floating_ip_assignment" "bastion" {
  count      = var.enabled == "true" ? length(var.floatingip_addresses) : 0
  droplet_id = digitalocean_droplet.bastion[count.index].id
  ip_address = var.floatingip_addresses[count.index]
}

resource "null_resource" "bastion_ssh_key" {
  count      = var.enabled == "true" ? 1 : 0
  depends_on = ["digitalocean_droplet.bastion"]
  triggers = {
    droplet = digitalocean_droplet.bastion[0].id
  }
  provisioner "local-exec" {
    command = "sleep 10 && scp -o StrictHostKeyChecking=no ${var.ssh_private_key} ${var.ssh_user}@${digitalocean_droplet.bastion[0].ipv4_address}:/home/${var.ssh_user}/.ssh"
  }
  provisioner "remote-exec" {
    inline = ["chmod 600 /home/${var.ssh_user}/.ssh/id_rsa"]
    connection {
      type        = "ssh"
      user        = var.ssh_user
      host        = digitalocean_droplet.bastion[0].ipv4_address
      private_key = file(var.ssh_private_key)
    }
  }
}
