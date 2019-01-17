/**
 * # Digital Ocean Rancher host configuration
 *
 * Provision a droplet with Rancher server.
 */
resource "digitalocean_tag" "rancherserver" {
  name = "rancherserver"
}

resource "digitalocean_tag" "rancheragent" {
  name = "rancheragent"
}

resource "digitalocean_droplet" "rancherserver" {
  count = "${var.enabled}"
  image = "${var.rancher_image}"
  name = "rancherserver.${var.environment}"
  region = "${var.do_region}"
  size = "s-1vcpu-2gb"
  private_networking = true
  monitoring = true
//  volume_ids = ["${digitalocean_volume.rancher_data.id}"]
  tags = ["${digitalocean_tag.rancherserver.name}"]
  ssh_keys = ["${var.ssh_key}"]
//  depends_on = ["digitalocean_volume.rancher_data"]
  user_data = <<EOF
#cloud-config
bootcmd:
  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

apt:
  sources:
    docker:
      source: deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable

packages:
  - apt-transport-https
  - ca-certificates
  - curl
  - software-properties-common
  - unattended-upgrades
  - docker-ce

timezone: Australia/Melbourne

ntp:
  enabled: true
  servers:
    - 0.au.pool.ntp.org
    - 1.au.pool.ntp.org
    - 2.au.pool.ntp.org
    - 3.au.pool.ntp.org

write_files:
  - path: /etc/log_files.yml
    content: |
      files:
        - /var/log/nginx/access.log
        - /var/log/nginx/error.log
      destination:
        host: ${var.papertrail_host}
        port: ${var.papertrail_port}
        protocol: tls
      pid_file: /var/run/remote_syslog.pid

runcmd:
  - docker run -d --restart=unless-stopped -p 8080:8080 rancher/server
  - "wget --header='X-Papertrail-Token: QHS89ESNb9Q0OGPK9Hu2' https://papertrailapp.com/destinations/2465304/setup.sh"
  - bash setup.sh
  - curl -O https://github.com/papertrail/remote_syslog2/releases/download/v0.20/remote-syslog2_0.20_amd64.deb
  - dpkg --install remote-syslog2_0.20_amd64.deb
  - remote_syslog
EOF
}

//resource "digitalocean_volume" "rancher_data" {
//  name = "rancher-data.${var.environment}"
//  region = "${var.do_region}"
//  size = 50
//}

resource "digitalocean_floating_ip" "rancherserver" {
  droplet_id = "${digitalocean_droplet.rancherserver.id}"
  region     = "${digitalocean_droplet.rancherserver.region}"
}
