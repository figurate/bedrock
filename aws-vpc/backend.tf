terraform {
  backend "remote" {
    workspaces {
      prefix = "aws-app-"
    }
  }
}
