data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type = "Service"
    }
  }
}

resource "aws_iam_role" "iam_keyrotation" {
  name = "bedrock-iam-keyrotation-role"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "iam_readonly" {
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
  role = "${aws_iam_role.iam_keyrotation.id}"
}

resource "aws_iam_role_policy_attachment" "iam_keyrotation" {
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-iam-keyrotation"
  role = "${aws_iam_role.iam_keyrotation.id}"
}

resource "aws_iam_role_policy_attachment" "lambda_config" {
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-lambda-config"
  role = "${aws_iam_role.iam_keyrotation.id}"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs" {
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-cloudwatch-logs"
  role = "${aws_iam_role.iam_keyrotation.id}"
}
