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
      type = "AWS"
    }
  }
}

data "aws_iam_policy_document" "iam_passrole_policy" {
  statement {
    actions = ["iam:PassRole"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/bedrock-ecs-cloudformation"]
  }
}

data "aws_iam_policy_document" "cloudformation_create_policy" {
  statement {
    actions = ["cloudformation:Create*"]
    resources = ["*"]
  }
}

resource "aws_iam_role" "clusteradmin" {
  name = "bedrock-ecs-clusteradmin"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

resource "aws_iam_role" "serviceadmin" {
  name = "ecs-bedrock-serviceadmin"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

resource "aws_iam_policy_attachment" "ecs_access" {
  name = "bedrock-ecs-access"
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_ReadOnly"
  roles = ["${aws_iam_role.clusteradmin.name}", "${aws_iam_role.serviceadmin.name}"]
}

resource "aws_iam_policy" "iam_passrole" {
  name = "bedrock-ecs-passrole"
  policy = "${data.aws_iam_policy_document.iam_passrole_policy.json}"
}

resource "aws_iam_policy_attachment" "iam_passrole" {
  name = "bedrock-ecs-passrole"
  policy_arn = "${aws_iam_policy.iam_passrole.arn}"
  roles = ["${aws_iam_role.clusteradmin.id}", "${aws_iam_role.serviceadmin.id}"]
}

resource "aws_iam_policy" "cloudformation_create" {
  policy = "${data.aws_iam_policy_document.cloudformation_create_policy.json}"
  roles = ["${aws_iam_role.clusteradmin.id}", "${aws_iam_role.serviceadmin.id}"]
}

resource "aws_iam_policy_attachment" "cloudformation_create" {
  name = "bedrock-ecs-cloudformation"
  policy_arn = "${aws_iam_policy.cloudformation_create.arn}"
  roles = ["${aws_iam_role.clusteradmin.id}", "${aws_iam_role.serviceadmin.id}"]
}
