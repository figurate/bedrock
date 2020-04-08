data "aws_iam_policy_document" "cloudformation_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["cloudformation.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "ecs_cloudformation" {
  name                  = "ecs-cloudformation-role"
  description           = "Role assumed by ECS Cloudformation stacks"
  path                  = var.role_path
  assume_role_policy    = data.aws_iam_policy_document.cloudformation_assume_role_policy.json
  force_detach_policies = true
}

resource "aws_iam_role_policy_attachment" "ec2_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role       = aws_iam_role.ecs_cloudformation.name
}
