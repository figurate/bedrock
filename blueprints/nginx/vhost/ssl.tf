resource "null_resource" "letencrypt" {
  count = var.letsencrypt_email != "" ? 1 : 0
  triggers = {
    email     = var.letsencrypt_email
    hostnames = join(",", var.hostnames)
  }
  provisioner "remote-exec" {
    inline = [
      "sudo certbot --non-interactive --agree-tos --email ${var.letsencrypt_email} --nginx -d ${var.hostnames[0]}"
    ]
    connection {
      type         = "ssh"
      user         = var.ssh_user
      host         = var.nginx_host
      private_key  = file(var.ssh_private_key)
      bastion_host = var.bastion_fqdn
    }
  }
}
