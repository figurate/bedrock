/**
 * # AWS Bastion role configuration
 *
 * Purpose: Provision IAM roles in AWS.
 *
 * Rationale: Bedrock blueprints use IAM roles to restrict the privileges of the provisioner.
 *
 * This script will create roles that has the following privileges:
 *
 * * Access for managing Bastion hosts specific to this blueprint
 * * Access to read/write Terraform state associated with the account
 */
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
      type = "AWS"
    }
  }
}

resource "aws_iam_role" "bastion_admin" {
  name = "bedrock-bastion-admin"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "ec2_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role = "${aws_iam_role.bastion_admin.name}"
}

resource "aws_iam_role_policy_attachment" "iam_passrole" {
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-iam-passrole"
  role = "${aws_iam_role.bastion_admin.id}"
}

resource "aws_iam_role_policy_attachment" "ec2_instance_profile_fullaccess" {
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-ec2-instance-profile-fullaccess"
  role = "${aws_iam_role.bastion_admin.id}"
}
