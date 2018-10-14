resource "null_resource" "vhost" {

  triggers {
    host = "${var.reverseproxy_host}"
  }

  provisioner "file" {
    content = <<EOF
upstream rancher {
    server ${digitalocean_droplet.rancherserver.ipv4_address_private}:8080;
}

map $http_upgrade $connection_upgrade {
    default Upgrade;
    ''      close;
}

# Uncomment after configuring SSL
#server {
#    listen 80;
#    listen [::]:80;
#    server_name ${var.hostname};
#    return 301 https://$server_name$request_uri;
#}

server {
    listen 80;
    listen [::]:80;

    server_name ${var.hostname};

	location / {
        proxy_pass http://rancher;
        proxy_http_version 1.1;
		proxy_set_header Host $host;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header X-Forwarded-Port $server_port;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
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
      "nginx -s reload",
      "certbot --non-interactive --agree-tos --nginx -d ${var.hostname}"
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