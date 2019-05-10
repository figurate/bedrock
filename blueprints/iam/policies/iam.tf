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

resource "aws_iam_policy" "iam_keyrotation" {
  name = "bedrock-iam-keyrotation"
  policy = "${data.aws_iam_policy_document.iam_keyrotation.json}"
}

resource "aws_iam_policy" "iam_servicerole_create" {
  name = "bedrock-iam-servicerole-create"
  policy = "${data.aws_iam_policy_document.iam_servicerole_create.json}"
}
