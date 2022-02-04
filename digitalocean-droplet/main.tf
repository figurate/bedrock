module "droplet" {
  source = "figurate/droplet/digitalocean"
  count  = length(var.droplets)

  name          = var.droplets[count.index][0]
  region        = var.droplets[count.index][1]
  template_type = var.droplets[count.index][2]
}
