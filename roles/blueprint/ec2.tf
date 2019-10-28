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

data "aws_iam_policy_document" "ec2_instance_profile_fullaccess" {
  statement {
    actions = [
      "iam:GetRole",
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:AttachRolePolicy",
      "iam:DetachRolePolicy",
    ]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/*"]
  }
  statement {
    actions = [
      "iam:CreateInstanceProfile",
      "iam:DeleteInstanceProfile",
      "iam:GetInstanceProfile",
      "iam:AddRoleToInstanceProfile",
      "iam:RemoveRoleFromInstanceProfile",
    ]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:instance-profile/*"]
  }
}

resource "aws_iam_policy" "ec2_subnet_fullaccess" {
  name   = "bedrock-ec2-subnet-fullaccess"
  policy = "${data.aws_iam_policy_document.ec2_subnet_fullaccess.json}"
}

resource "aws_iam_policy" "ec2_instance_profile_fullaccess" {
  name   = "bedrock-ec2-instance-profile-fullaccess"
  policy = "${data.aws_iam_policy_document.ec2_instance_profile_fullaccess.json}"
}
