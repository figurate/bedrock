data "aws_iam_policy_document" "codebuild_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["codebuild.amazonaws.com"]
      type = "Service"
    }
  }
}

resource "aws_iam_role" "codebuild" {
  name = "bedrock-codebuild-role"
  assume_role_policy = "${data.aws_iam_policy_document.codebuild_assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "ec2_fullaccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role = "${aws_iam_role.codebuild.id}"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-cloudwatch-logs"
  role = "${aws_iam_role.codebuild.id}"
}
