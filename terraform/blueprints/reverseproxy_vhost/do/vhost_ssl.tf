resource "null_resource" "vhost_ssl" {

  count = "${replace(replace(var.ssl_enabled, "/false/", 0), "/true/", 1)}"

  triggers {
    host = "${var.reverseproxy_host}"
    targets = "${join(",", var.target_hosts)}"
    ssl_enabled = "${var.ssl_enabled}"
  }

  provisioner "file" {
    content = <<EOF
upstream ${local.uuid}.internal {
${join("\n", formatlist("    server %s:8080;", var.target_hosts))}
}

# Uncomment after configuring SSL
#server {
#    listen 80;
#    listen [::]:80;
#    server_name ${join(" ", var.hostnames)};
#    return 301 https://${var.hostnames[0]}$request_uri;
#}

server {
    listen 80;
    listen [::]:80;

    server_name ${join(" ", var.hostnames)};

    error_page 404 /404.html;

    location = /404.html {
        root /var/www/html/error/;
        internal;
    }

    location /images/railway-bridge.jpeg {
        root /var/www/;
    }

	location / {
        proxy_pass http://${local.uuid}.internal;
        proxy_http_version 1.1;
		proxy_set_header Host $host;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
EOF
    destination = "/etc/nginx/sites-available/${var.hostnames[0]}"

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
      "ln -fs /etc/nginx/sites-available/${var.hostnames[0]} /etc/nginx/sites-enabled/",
      "nginx -t",
      "nginx -s reload",
      "certbot --non-interactive --agree-tos --nginx -d ${var.hostnames[0]}"
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