/**
 * # AWS IAM policies
 *
 * Purpose: Provision IAM policies in AWS.
 *
 * Rationale: Bedrock blueprints use IAM roles to restrict the privileges of the provisioner.
 *
 * This script will create policies for common activities that may be attached to roles.
 */
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "iam_passrole_policy" {
  statement {
    actions = ["iam:PassRole"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/bedrock-*"]
  }
}

data "aws_iam_policy_document" "cloudformation_create_policy" {
  statement {
    actions = [
      "cloudformation:Create*",
      "cloudformation:Update*",
      "cloudformation:Delete*",
    ]
    resources = ["arn:aws:cloudformation:${var.region}:${data.aws_caller_identity.current.account_id}:stack/*"]
  }
}

data "aws_iam_policy_document" "ec2_subnet_fullaccess" {
  statement {
    actions = [
      "ec2:CreateSubnet",
      "ec2:DeleteSubnet",
      "ec2:DisassociateSubnetCidrBlock",
      "ec2:ModifySubnetAttribute",
      "ec2:DescribeSubnets",
      "ec2:AssociateSubnetCidrBlock",
      "ec2:CreateDefaultSubnet",
    ]
    resources = ["arn:aws:cloudformation:${var.region}:${data.aws_caller_identity.current.account_id}:*"]
  }
}

data "aws_iam_policy_document" "ec2_instance_profile_fullaccess" {
  statement {
    actions = [
      "iam:Create*",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:Delete*",
    ]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/bedrock-*"]
  }
  statement {
    actions = [
      "iam:AddRoleToInstanceProfile",
      "iam:RemoveRoleFromInstanceProfile",
    ]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:instance-profile/bedrock-*"]
  }
}

resource "aws_iam_policy" "ec2_subnet_fullaccess" {
  name = "bedrock-ec2-subnet-fullaccess"
  policy = "${data.aws_iam_policy_document.ec2_subnet_fullaccess.json}"
}

resource "aws_iam_policy" "ec2_instance_profile_fullaccess" {
  name = "bedrock-ec2-instance-profile-fullaccess"
  policy = "${data.aws_iam_policy_document.ec2_instance_profile_fullaccess.json}"
}

resource "aws_iam_policy" "iam_passrole" {
  name = "bedrock-iam-passrole"
  policy = "${data.aws_iam_policy_document.iam_passrole_policy.json}"
}

resource "aws_iam_policy" "cloudformation_create" {
  name = "bedrock-cloudformation-create"
  policy = "${data.aws_iam_policy_document.cloudformation_create_policy.json}"
}
