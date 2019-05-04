data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "s3_terraform_access" {
  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject"
    ]
    resources = ["arn:aws:s3:::${data.aws_caller_identity.current.account_id}-terraform-state/*"]
  }
  statement {
    actions = [
      "s3:ListBucket"
    ]
    resources = ["arn:aws:s3:::${data.aws_caller_identity.current.account_id}-terraform-state"]
  }
}

resource "aws_iam_user" "iamadmin" {
  name = "iamadmin"
}

resource "aws_iam_access_key" "iamadmin" {
  user = "${aws_iam_user.iamadmin.name}"
}

resource "aws_iam_user_policy_attachment" "iam_access" {
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
  user = "${aws_iam_user.iamadmin.name}"
}

resource "aws_iam_policy" "s3_terraform_access" {
  policy = "${data.aws_iam_policy_document.s3_terraform_access.json}"
}

resource "aws_iam_user_policy_attachment" "s3_terraform_access" {
  policy_arn = "${aws_iam_policy.s3_terraform_access.arn}"
  user = "${aws_iam_user.iamadmin.name}"
}
