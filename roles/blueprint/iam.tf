data "aws_iam_policy_document" "iam_passrole_policy" {
  statement {
    actions   = ["iam:PassRole"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/*"]
  }
}

data "aws_iam_policy_document" "cloudformation_passrole_policy" {
  statement {
    actions   = ["iam:PassRole"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/*-cloudformation-role"]
  }
}

data "aws_iam_policy_document" "iam_keyrotation" {
  statement {
    actions = [
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:UpdateAccessKey",
    ]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/*"]
  }
}

data "aws_iam_policy_document" "iam_servicerole_create" {
  statement {
    actions = [
      "iam:CreateServiceLinkedRole",
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "iam_assumerole" {
  statement {
    actions = [
      "iam:ListRoles",
    ]
    resources = ["*"]
  }

  statement {
    actions = [
      "sts:AssumeRole",
    ]
    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/*-blueprint-role",
    ]
  }
}

data "aws_iam_policy_document" "iam_groupadmin" {
  statement {
    actions = [
      "iam:ListGroups",
      "iam:CreateGroup",
      "iam:DeleteGroup",
    ]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:*"]
  }
}

data "aws_iam_policy_document" "instance_profile_fullaccess" {
  statement {
    actions = [
      "iam:GetRole",
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
    ]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/*"]
  }
  statement {
    actions = [
      "iam:CreateInstanceProfile",
      "iam:DeleteInstanceProfile",
      "iam:GetInstanceProfile",
      "iam:AddRoleToInstanceProfile",
      "iam:RemoveRoleFromInstanceProfile",
    ]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:instance-profile/*"]
  }
}

resource "aws_iam_policy" "iam_passrole" {
  name        = "bedrock-iam-passrole"
  description = "Deprecated: use bedrock-cloudformation-passrole"
  policy      = data.aws_iam_policy_document.iam_passrole_policy.json
}

resource "aws_iam_policy" "cloudformation_passrole" {
  name        = "bedrock-cloudformation-passrole"
  description = "Permission to pass role to cloudformation"
  policy      = data.aws_iam_policy_document.cloudformation_passrole_policy.json
}

resource "aws_iam_policy" "iam_keyrotation" {
  name        = "bedrock-iam-keyrotation"
  description = "Manage IAM access keys"
  policy      = data.aws_iam_policy_document.iam_keyrotation.json
}

resource "aws_iam_policy" "iam_servicerole_create" {
  name        = "bedrock-iam-servicerole-create"
  description = "Create IAM service-linked roles"
  policy      = data.aws_iam_policy_document.iam_servicerole_create.json
}

resource "aws_iam_policy" "iam_assumerole" {
  name        = "bedrock-iam-assumerole"
  description = "Assume blueprint IAM roles"
  policy      = data.aws_iam_policy_document.iam_assumerole.json
}

resource "aws_iam_policy" "iam_groupadmin" {
  name        = "bedrock-iam-groupadmin"
  description = "Manage IAM user groups"
  policy      = data.aws_iam_policy_document.iam_groupadmin.json
}

resource "aws_iam_policy" "iam_instance_profile" {
  name        = "bedrock-instance-profile-fullaccess"
  description = "Manage IAM instance profiles"
  policy      = data.aws_iam_policy_document.instance_profile_fullaccess.json
}
