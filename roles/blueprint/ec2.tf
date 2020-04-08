data "aws_iam_policy_document" "ec2_subnet_fullaccess" {
  statement {
    actions = [
      "ec2:CreateSubnet",
      "ec2:DeleteSubnet",
      "ec2:DisassociateSubnetCidrBlock",
      "ec2:ModifySubnetAttribute",
      "ec2:DescribeSubnets",
      "ec2:AssociateSubnetCidrBlock",
      "ec2:CreateDefaultSubnet",
    ]
    resources = ["arn:aws:cloudformation:${var.region}:${data.aws_caller_identity.current.account_id}:*"]
  }
}

resource "aws_iam_policy" "ec2_subnet_fullaccess" {
  name        = "bedrock-ec2-subnet-fullaccess"
  description = "Manage VPC Subnets"
  policy      = data.aws_iam_policy_document.ec2_subnet_fullaccess.json
}
