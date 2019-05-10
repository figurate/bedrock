data "aws_iam_policy_document" "ec2_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type = "Service"
    }
  }
}

resource "aws_iam_role" "bastion_instance" {
  name = "bedrock-bastion-instance"
  assume_role_policy = "${data.aws_iam_policy_document.ec2_assume_role_policy.json}"
}
resource "aws_iam_role_policy_attachment" "ec2_ssm" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  role = "${aws_iam_role.bastion_instance.name}"
}

resource "aws_iam_role_policy_attachment" "ec2_cloudwatch" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  role = "${aws_iam_role.bastion_instance.name}"
}
