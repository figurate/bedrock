/**
 * # Digital Ocean Bastion host configuration
 *
 * Provision a droplet with SSH ingress authenticated with the specified public key.
 */
data "template_file" "userdata" {
  template = "${file(format("%s/%s.yml", var.userdata_path, var.image_os))}"

  vars {
    AuthorizedUserName   = "${var.bastion_user}"
    AuthorizedUserSSHKey = "${var.ssh_key}"
    ShutdownDelay        = "${var.shutdown_delay}"
  }
}

resource "digitalocean_tag" "bastion" {
  name = "${local.uuid}"
}

resource "digitalocean_droplet" "bastion" {
  count              = "${var.enabled}"
  image              = "${var.bastion_image}"
  name               = "${local.uuid}"
  region             = "${var.do_region}"
  size               = "s-1vcpu-1gb"
  private_networking = true
  monitoring         = true
  tags               = ["${digitalocean_tag.bastion.name}"]
  ssh_keys           = ["${var.ssh_key}"]
  user_data          = "${data.template_file.userdata.rendered}"
}

resource "null_resource" "bastion_ssh_key" {
  depends_on = ["digitalocean_droplet.bastion"]

  provisioner "local-exec" {
    command = "scp ${var.ssh_private_key} root@${digitalocean_droplet.bastion.ipv4_address}:/root/.ssh"
  }

  provisioner "remote-exec" {
    inline = ["chmod 600 /root/.ssh/id_rsa"]

    connection {
      type        = "ssh"
      user        = "root"
      host        = "${digitalocean_droplet.bastion.ipv4_address}"
      private_key = "${file(var.ssh_private_key)}"
    }
  }
}
