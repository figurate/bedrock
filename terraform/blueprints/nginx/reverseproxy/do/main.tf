/**
 * # Digital Ocean Reverse Proxy host configuration
 *
 * Provision a droplet with NGINX and letsencrypt installed.
 */
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
  - content: |
      files:
        - /var/log/nginx/access.log
        - /var/log/nginx/error.log
      destination:
        host: ${var.papertrail_host}
        port: ${var.papertrail_port}
        protocol: tls
      pid_file: /var/run/remote_syslog.pid
    path: /etc/log_files.yml

runcmd:
  - export API_KEY="${var.amplify_key}"
  - curl -L https://github.com/nginxinc/nginx-amplify-agent/raw/master/packages/install.sh | bash
  - "wget --header='X-Papertrail-Token: QHS89ESNb9Q0OGPK9Hu2' https://papertrailapp.com/destinations/2465304/setup.sh"
  - bash setup.sh
  - curl -O https://github.com/papertrail/remote_syslog2/releases/download/v0.20/remote-syslog2_0.20_amd64.deb
  - dpkg --install remote-syslog2_0.20_amd64.deb
  - remote_syslog
EOF
}

resource "digitalocean_floating_ip" "reverseproxy" {
  droplet_id = "${digitalocean_droplet.reverseproxy.id}"
  region     = "${digitalocean_droplet.reverseproxy.region}"
}
