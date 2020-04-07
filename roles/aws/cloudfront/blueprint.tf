resource "aws_iam_role" "blueprint" {
  name               = "cloudfront-blueprint-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "cloudfront_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/CloudFrontFullAccess"
  role       = aws_iam_role.blueprint.name
}

resource "aws_iam_role_policy_attachment" "s3_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.blueprint.name
}

resource "aws_iam_role_policy_attachment" "route53_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
  role       = aws_iam_role.blueprint.name
}

resource "aws_iam_role_policy_attachment" "lambda_readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaReadOnlyAccess"
  role       = aws_iam_role.blueprint.id
}

resource "aws_iam_role_policy_attachment" "iam_servicerole_create" {
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-iam-servicerole-create"
  role       = aws_iam_role.blueprint.id
}
