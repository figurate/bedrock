resource "digitalocean_volume" volume {
  count                    = var.volume_count
  name                     = "${var.environment}${count.index + 1}-${var.volume_name}"
  region                   = var.do_region
  size                     = var.volume_size
  initial_filesystem_label = var.volume_label != "" ? var.volume_label : null
  initial_filesystem_type  = var.volume_type
}
