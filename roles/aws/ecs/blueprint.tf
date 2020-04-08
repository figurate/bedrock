resource "aws_iam_role" "blueprint" {
  name                  = "ecs-blueprint-role"
  description           = "Role assumed by Bedrock blueprints"
  path                  = var.role_path
  assume_role_policy    = data.aws_iam_policy_document.assume_role_policy.json
  force_detach_policies = true
}

resource "aws_iam_role_policy_attachment" "iam_readonly" {
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
  role       = aws_iam_role.blueprint.name
}

resource "aws_iam_role_policy_attachment" "route53_readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53ReadOnlyAccess"
  role       = aws_iam_role.blueprint.name
}

resource "aws_iam_role_policy_attachment" "cloudformation_passrole" {
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-cloudformation-passrole"
  role       = aws_iam_role.blueprint.name
}
