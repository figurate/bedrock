data "aws_iam_policy_document" "cloudformation_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["cloudformation.amazonaws.com"]
      type = "Service"
    }
  }
}

data "aws_iam_policy_document" "cloudformation_iam_passrole_policy" {
  statement {
    actions = ["iam:PassRole"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "iam_create_policy" {
  statement {
    actions = [
      "iam:Create*",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
      "iam:Delete*",
      "iam:AddRoleToInstanceProfile",
      "iam:RemoveRoleFromInstanceProfile",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "nginx_cloudformation" {
  name = "bedrock-nginx-cloudformation"
  assume_role_policy = "${data.aws_iam_policy_document.cloudformation_assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "ec2_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role = "${aws_iam_role.nginx_cloudformation.name}"
}

resource "aws_iam_role_policy" "cloudformation_iam_passrole" {
  policy = "${data.aws_iam_policy_document.cloudformation_iam_passrole_policy.json}"
  role = "${aws_iam_role.nginx_cloudformation.id}"
}

resource "aws_iam_role_policy" "iam_create" {
  policy = "${data.aws_iam_policy_document.iam_create_policy.json}"
  role = "${aws_iam_role.nginx_cloudformation.id}"
}
