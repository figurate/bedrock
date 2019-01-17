resource "null_resource" "vhost" {

  count = "${replace(replace(var.ssl_enabled, "/false/", 1), "/true/", 0)}"

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

    location ~ /system/.* {
		return 403;
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