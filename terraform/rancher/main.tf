resource "digitalocean_droplet" "rancher-master" {
  image = "33755616"
  name = "rancher-master"
  region = "sgp1"
  size = "2gb"
  private_networking = true
  monitoring = true
  volume_ids = ["${digitalocean_volume.rancher.id}"]
}

resource "digitalocean_volume" "rancher" {
  name = "rancher-store"
  region = "sgp1"
  size = 50
}
