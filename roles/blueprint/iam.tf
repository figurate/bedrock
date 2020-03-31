data "aws_iam_policy_document" "iam_passrole_policy" {
  statement {
    actions   = ["iam:PassRole"]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/*"]
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
      "iam:GetRole",
      "iam:AssumeRole",
    ]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/bedrock*"]
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

resource "aws_iam_policy" "iam_passrole" {
  name   = "bedrock-iam-passrole"
  policy = data.aws_iam_policy_document.iam_passrole_policy.json
}

resource "aws_iam_policy" "iam_keyrotation" {
  name   = "bedrock-iam-keyrotation"
  policy = data.aws_iam_policy_document.iam_keyrotation.json
}

resource "aws_iam_policy" "iam_servicerole_create" {
  name   = "bedrock-iam-servicerole-create"
  policy = data.aws_iam_policy_document.iam_servicerole_create.json
}

resource "aws_iam_policy" "iam_assumerole" {
  name   = "bedrock-iam-assumerole"
  policy = data.aws_iam_policy_document.iam_assumerole.json
}

resource "aws_iam_policy" "iam_groupadmin" {
  name   = "bedrock-iam-groupadmin"
  policy = data.aws_iam_policy_document.iam_groupadmin.json
}
