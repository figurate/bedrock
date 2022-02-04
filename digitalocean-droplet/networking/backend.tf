terraform {
  backend "remote" {
    organization="micronode"
    workspaces {
      prefix = "do-networking-"
    }
  }
}
