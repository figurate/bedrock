/**
 * # AWS ECS role configuration
 *
 * Purpose: Provision IAM roles in AWS.
 *
 * Rationale: Bedrock blueprints use IAM roles to restrict the privileges of the provisioner.
 *
 * This script will create roles that has the following privileges:
 *
 * * Access for managing ECS clusters specific to this blueprint
 * * Access for managing ECS services specific to this blueprint
 * * Access to read/write Terraform state associated with the account
 */
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
      type        = "AWS"
    }
  }
}

data "aws_iam_policy" "cloudformation_create_policy" {
  arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-cloudformation-create"
}

resource "aws_iam_role" "serviceadmin" {
  name                  = "ecs-service-admin"
  path                  = var.role_path
  assume_role_policy    = data.aws_iam_policy_document.assume_role_policy.json
  force_detach_policies = true
}

resource "aws_iam_role" "codedeploy" {
  name               = "ecs-codedeploy-role"
  path               = var.role_path
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_policy_attachment" "ecs_access" {
  name       = "bedrock-ecs-access"
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
  roles      = [aws_iam_role.blueprint.name, aws_iam_role.serviceadmin.name]
}

resource "aws_iam_policy_attachment" "cloudformation_create" {
  name       = "bedrock-ecs-cloudformation"
  policy_arn = data.aws_iam_policy.cloudformation_create_policy.arn
  roles      = [aws_iam_role.blueprint.id, aws_iam_role.serviceadmin.id]
}
