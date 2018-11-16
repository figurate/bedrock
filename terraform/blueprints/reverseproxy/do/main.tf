/**
 * # Digital Ocean Reverse Proxy host configuration
 *
 * Provision a droplet with NGINX and letsencrypt installed.
 */
provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_tag" "reverseproxy" {
  name = "reverseproxy"
}

resource "digitalocean_droplet" "reverseproxy" {
  count = "${var.enabled}"
  image = "${var.reverseproxy_image}"
  name = "reverseproxy.${var.environment}"
  region = "${var.do_region}"
  size = "s-1vcpu-1gb"
  private_networking = true
  monitoring = true
  tags = ["${digitalocean_tag.reverseproxy.name}"]
  ssh_keys = ["${var.ssh_key}"]
  user_data = <<EOF
#cloud-config
apt:
  sources:
    certbot:
      source: ppa:certbot/certbot

packages:
  - nginx
  - unattended-upgrades
  - curl
  - ntpdate
  - python
  - python-certbot-nginx

timezone: Australia/Melbourne

ntp:
  enabled: true
  servers:
    - 0.au.pool.ntp.org
    - 1.au.pool.ntp.org
    - 2.au.pool.ntp.org
    - 3.au.pool.ntp.org

write_files:
  - content: |
      server {
          listen 127.0.0.1:80;
          server_name 127.0.0.1;
          location /nginx_status {
              stub_status on;
              allow 127.0.0.1;
              deny all;
          }
      }
    path: /etc/nginx/conf.d/stub_status.conf

runcmd:
  - export API_KEY="${var.amplify_key}"
  - curl -L https://github.com/nginxinc/nginx-amplify-agent/raw/master/packages/install.sh | bash
EOF
}

resource "digitalocean_floating_ip" "reverseproxy" {
  droplet_id = "${digitalocean_droplet.reverseproxy.id}"
  region     = "${digitalocean_droplet.reverseproxy.region}"
}
