data "template_file" "vhost_config" {
  template = file(format("%s/%s.conf", var.template_path, var.target_type))
  vars = {
    UpstreamUUID  = "${local.uuid}.internal"
    UpstreamHosts = join("\n", formatlist("    server %s:8080;", var.upstream_hosts))
    Hostnames     = join(" ", var.hostnames)
    HostDefault   = var.hostnames[0]
    TargetHost    = var.target_host
  }
}

resource "null_resource" "vhost" {
  triggers = {
    config    = data.template_file.vhost_config.rendered
    locations = var.locations_config != "" ? file(var.locations_config) : null
  }
  provisioner "remote-exec" {
    inline = [
      "mkdir -p /tmp/etc/nginx/conf.d",
    ]
    connection {
      type         = "ssh"
      user         = var.ssh_user
      host         = var.nginx_host
      private_key  = file(var.ssh_private_key)
      bastion_host = var.bastion_fqdn
    }
  }

  provisioner "file" {
    content     = data.template_file.vhost_config.rendered
    destination = "/tmp/etc/nginx/conf.d/${var.hostnames[0]}.conf"
    connection {
      type         = "ssh"
      user         = var.ssh_user
      host         = var.nginx_host
      private_key  = file(var.ssh_private_key)
      bastion_host = var.bastion_fqdn
    }
  }
  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/etc/nginx/conf.d/${var.hostnames[0]}.* /etc/nginx/conf.d/",
      "sudo nginx -t",
      "sudo nginx -s reload",
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
