/**
 * # AWS RDS role configuration
 *
 * Purpose: Provision IAM roles in AWS.
 *
 * Rationale: Bedrock blueprints use IAM roles to restrict the privileges of the provisioner.
 *
 * This script will create a role that has the following privileges:
 *
 * * Access for managing RDS clusters and instances specific to this blueprint
 * * Access to read/write Terraform state associated with the account
 */
data "aws_caller_identity" "current" {}

resource "aws_iam_role" "rdsadmin" {
  name               = "rds-bedrock-admin"
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

resource "aws_iam_role_policy_attachment" "rds_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
  role       = "${aws_iam_role.rdsadmin.name}"
}
