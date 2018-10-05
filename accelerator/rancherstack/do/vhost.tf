resource "null_resource" "vhost" {

  triggers {
    host = "${var.reverseproxy_host}"
  }

  provisioner "file" {
    content = <<EOF
server {
    listen 80;
    listen [::]:80;

    server_name ${var.hostname};

	location / {
        proxy_pass ${var.target_url};
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