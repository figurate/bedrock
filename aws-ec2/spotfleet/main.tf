/**
 * # AWS SpotFleet role configuration
 *
 * Purpose: Provision IAM roles in AWS.
 *
 * Rationale: Bedrock blueprints use IAM roles to restrict the privileges of the provisioner.
 *
 * This script will create roles that has the following privileges:
 *
 * * Access for managing Spot Fleet clusters specific to this blueprint
 * * Access to read/write Terraform state associated with the account
 */
data "aws_caller_identity" "current" {}

resource "aws_iam_role" "clusteradmin" {
  name = "spotfleet-bedrock-clusteradmin"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "Bool": { "aws:MultiFactorAuthPresent": "${var.mfa_required}" }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "spotfleet_access_clusteradmin" {
  policy_arn = "arn:aws:iam::aws:policy/AWSEC2SpotFleetServiceRolePolicy"
  role = "${aws_iam_role.clusteradmin.name}"
}

//resource "aws_iam_role_policy_attachment" "s3_terraform_access_clusteradmin" {
//  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-terraform-state"
//  role = "${aws_iam_role.clusteradmin.name}"
//}
