terraform {
  backend "s3" {
    dynamodb_table = "terraform-lock"
    key            = "bedrock/aws/tenancy/terraform.tfstate"
  }

  //  backend "remote" {
  //    workspaces {
  //      prefix = "bedrock-aws-tenancy-"
  //    }
  //  }
}
