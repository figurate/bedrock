provider "rancher" {
  api_url = "${var.rancher_url}"
  access_key = "${var.rancher_access_key}"
  secret_key = "${var.rancher_secret_key}"
}

resource "rancher_environment" "environment" {
  name = "${var.environment}"
  orchestration = "cattle"
}

resource "rancher_host" "host" {
  count = "${var.host_count}"
  environment_id = "${rancher_environment.environment.id}"
  hostname = "rancheragent${count.index}-${var.environment}"
  name = "rancheragent${count.index}-${var.environment}"
}

resource "digitalocean_floating_ip" "rancheragent" {
  droplet_id = "${rancher_host.host.}"
  region     = "${digitalocean_droplet.rancherserver.region}"
}

resource "rancher_stack" "cowcheck" {
  environment_id = "${rancher_environment.environment.id}"
  name = "cowcheck"
  catalog_id = "community:cowcheck:0"
  start_on_create = true
}