resource "aws_iam_role" "blueprint" {
  name                  = "ecr-blueprint-role"
  description           = "Role assumed by Bedrock blueprints"
  path                  = var.role_path
  assume_role_policy    = data.aws_iam_policy_document.assume_role_policy.json
  force_detach_policies = true
}

resource "aws_iam_role_policy_attachment" "ecr_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  role       = aws_iam_role.blueprint.id
}
