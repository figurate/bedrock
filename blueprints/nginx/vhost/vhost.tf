data "template_file" "vhost_config" {
  template = file(format("%s/%s.conf", var.template_path, var.target_type))
  vars = {
    UpstreamUUID = "${local.uuid}.internal"
    UpstreamHosts = "${join("\n", formatlist("    server %s:8080;", var.target_hosts))}"
    Hostnames = "${join(" ", var.hostnames)}"
    HostDefault = "${var.hostnames[0]}"
    StaticHost = "${var.static_host}"
  }
}

resource "null_resource" "vhost" {
  triggers {
    config = "${data.template_file.vhost_config.rendered}"
    locations = "${file(var.locations_config)}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /tmp/etc/nginx/conf.d",
    ]
    connection {
      type     = "ssh"
      user     = "${var.reverseproxy_user}"
      host = "${var.reverseproxy_host}"
      private_key = "${file(var.ssh_private_key)}"
      bastion_host = "${var.bastion_host}"
    }
  }

  provisioner "file" {
    content = "${file(var.locations_config)}"
    destination = "/tmp/etc/nginx/conf.d/${var.hostnames[0]}.locations"
    connection {
      type     = "ssh"
      user     = "${var.reverseproxy_user}"
      host = "${var.reverseproxy_host}"
      private_key = "${file(var.ssh_private_key)}"
      bastion_host = "${var.bastion_host}"
    }
  }

  provisioner "file" {
    content = "${data.template_file.vhost_config.rendered}"
    destination = "/tmp/etc/nginx/conf.d/${var.hostnames[0]}.conf"
    connection {
      type     = "ssh"
      user     = "${var.reverseproxy_user}"
      host = "${var.reverseproxy_host}"
      private_key = "${file(var.ssh_private_key)}"
      bastion_host = "${var.bastion_host}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/etc/nginx/conf.d/${var.hostnames[0]}.* /etc/nginx/conf.d/",
      "sudo nginx -t",
      "sudo nginx -s reload",
    ]
    connection {
      type     = "ssh"
      user     = "${var.reverseproxy_user}"
      host = "${var.reverseproxy_host}"
      private_key = "${file(var.ssh_private_key)}"
      bastion_host = "${var.bastion_host}"
    }
  }
}

resource "null_resource" "letencrypt" {
  count = "${replace(replace(var.ssl_enabled, "/false/", 0), "/true/", 1)}"

  triggers {
    email = "${var.letsencrypt_email}"
    hostname = "${join("", var.hostnames)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo certbot --non-interactive --agree-tos --email ${var.letsencrypt_email} --nginx -d ${var.hostnames[0]}"
    ]
    connection {
      type     = "ssh"
      user     = "${var.reverseproxy_user}"
      host = "${var.reverseproxy_host}"
      private_key = "${file(var.ssh_private_key)}"
      bastion_host = "${var.bastion_host}"
    }
  }
}
