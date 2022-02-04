resource "aws_iam_role" "blueprint" {
  name               = "chime-blueprint-role"
  description        = "Role assumed by Bedrock blueprints"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaFullAccess"
  role       = aws_iam_role.blueprint.id
}
