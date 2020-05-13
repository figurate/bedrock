/**
 * # AWS IAM role configuration
 *
 * Purpose: Provision IAM roles in AWS.
 *
 * Rationale: Bedrock blueprints use IAM roles to restrict the privileges of the provisioner.
 *
 * This script will create a role that has the following privileges:
 *
 * * IAM access to assume other IAM roles specific a blueprint
 * * Access to read/write Terraform state associated with the account
 * * Access to manage Terraform state locks associated with the blueprint
 */
data "aws_caller_identity" "current" {}

module "iam_policies" {
  source = "micronode/iam-policies/aws"

  region             = var.region
  name_prefix        = "bedrock"
  assume_role_filter = "*-blueprint-role"
}

module "blueprintadmin" {
  source = "micronode/iam-role/aws"

  name        = "bedrock-blueprint-admin"
  description = "Bedrock role used to provision blueprints and blueprint roles"
  path        = var.role_path
  principal   = "account"
  policies = [
    module.iam_policies.iam_assumerole_arn,
    module.iam_policies.s3_terraform_access_arn,
    module.iam_policies.dynamodb_terraform_access_arn,
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser",
  ]
}
