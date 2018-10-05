provider "rancher" {
  api_url = "${var.rancher_url}"
  access_key = "${var.rancher_access_key}"
  secret_key = "${var.rancher_secret_key}"
}

data "rancher_environment" "environment" {
  name = "${var.environment}"
}

resource "rancher_stack" "catalog_stack" {
  count = "${length(var.catalog_id) > 0}"
  environment_id = "${data.rancher_environment.environment.id}"
  name = "${var.stack_name}"
  catalog_id = "${var.catalog_id}"
  start_on_create = true
}

resource "rancher_stack" "stack" {
  count = "${length(var.catalog_id) <= 0}"
  environment_id = "${data.rancher_environment.environment.id}"
  name = "${var.stack_name}"
  docker_compose = "${file(var.docker_compose)}"
  rancher_compose = "${file(var.rancher_compose)}"
  start_on_create = true
}
