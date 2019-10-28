data "aws_iam_policy_document" "cloudformation_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["cloudformation.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "nginx_cloudformation" {
  name               = "bedrock-nginx-cloudformation"
  assume_role_policy = "${data.aws_iam_policy_document.cloudformation_assume_role_policy.json}"
}

resource "aws_iam_role_policy_attachment" "ec2_full_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role       = "${aws_iam_role.nginx_cloudformation.name}"
}

resource "aws_iam_role_policy_attachment" "cloudformation_iam_passrole" {
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-iam-passrole"
  role       = "${aws_iam_role.nginx_cloudformation.id}"
}

resource "aws_iam_role_policy_attachment" "ec2_instance_profile_fullaccess" {
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-ec2-instance-profile-fullaccess"
  role       = "${aws_iam_role.nginx_cloudformation.id}"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_log_groups" {
  policy_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/bedrock-cloudwatch-log-groups"
  role       = "${aws_iam_role.nginx_cloudformation.id}"
}

resource "aws_iam_role_policy_attachment" "route53_access" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
  role       = "${aws_iam_role.nginx_cloudformation.name}"
}
