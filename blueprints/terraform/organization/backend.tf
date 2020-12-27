terraform {
  backend "remote" {
    workspaces {
      prefix = "tfe-organization-"
    }
  }
}
