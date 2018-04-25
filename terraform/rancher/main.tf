resource "digitalocean_droplet" "rancher-master" {
  image = "packer-1524626585"
  name = "rancher-master"
  region = "sgp1"
  size = "2gb"
  ipv4_address_private = "true"
  volume_ids = ["${digitalocean_volume.rancher.id}"]
}

resource "digitalocean_volume" "rancher" {
  name = "rancher-store"
  region = "sgp1"
  size = 50gb
}
