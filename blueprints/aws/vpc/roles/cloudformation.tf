data "aws_iam_policy_document" "cloudformation_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["cloudformation.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "vpc_cloudformation" {
  name               = "bedrock-vpc-cloudformation"
  assume_role_policy = "${data.aws_iam_policy_document.cloudformation_assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "vpc_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
  role       = "${aws_iam_role.vpc_cloudformation.name}"
}

resource "aws_iam_role_policy_attachment" "cloudformation_iam_passrole" {
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-iam-passrole"
  role       = "${aws_iam_role.vpc_cloudformation.name}"
}
