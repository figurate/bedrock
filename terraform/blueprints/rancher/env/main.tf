/**
 * # Rancher environment configuration
 *
 * Provision an environment on a Rancher server instance.
 */
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
  droplet_id = "${rancher_host.host.id}"
  region     = "${var.region}"
}

resource "rancher_stack" "cowcheck" {
  environment_id = "${rancher_environment.environment.id}"
  name = "cowcheck"
  catalog_id = "community:cowcheck:0"
  start_on_create = true
}