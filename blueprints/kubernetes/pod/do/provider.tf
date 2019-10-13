provider "digitalocean" {
}

provider "kubernetes" {
  host                   = data.digitalocean_kubernetes_cluster.cluster.endpoint
  client_certificate     = base64decode(data.digitalocean_kubernetes_cluster.cluster.kube_config.0.client_certificate)
  client_key             = base64decode(data.digitalocean_kubernetes_cluster.cluster.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(data.digitalocean_kubernetes_cluster.cluster.kube_config.0.cluster_ca_certificate)
}
