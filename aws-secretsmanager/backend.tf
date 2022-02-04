terraform {
  backend "remote" {
    workspaces {
      prefix = "aws-env-"
    }
  }
}
