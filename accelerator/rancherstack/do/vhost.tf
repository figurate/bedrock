resource "null_resource" "vhost" {

  count = "${replace(replace(var.ssl_enabled, "/false/", 1), "/true/", 0)}"

  triggers {
    host = "${var.reverseproxy_host}"
    targets = "${join(",", var.target_hosts)}"
    port = "${var.target_port}"
    ssl_enabled = "${var.ssl_enabled}"
  }

  provisioner "file" {
    content = <<EOF
upstream ${local.uuid}.internal {
${join("\n", formatlist("    server %s:%s;", var.target_hosts, var.target_port))}
}

server {
    listen 80;
    listen [::]:80;

    server_name ${var.hostname};

	location / {
        proxy_pass http://${local.uuid}.internal;
        proxy_http_version 1.1;
		proxy_set_header Host $host;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
EOF
    destination = "/etc/nginx/sites-available/${var.hostname}"

    connection {
      type     = "ssh"
      user     = "root"
      host = "${var.reverseproxy_host}"
      private_key = "${file(var.ssh_private_key)}"
      bastion_host = "${var.bastion_host}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "ln -fs /etc/nginx/sites-available/${var.hostname} /etc/nginx/sites-enabled/",
      "nginx -t",
      "nginx -s reload"
    ]

    connection {
      type     = "ssh"
      user     = "root"
      host = "${var.reverseproxy_host}"
      private_key = "${file(var.ssh_private_key)}"
      bastion_host = "${var.bastion_host}"
    }
  }
}