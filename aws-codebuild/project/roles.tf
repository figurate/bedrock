resource "aws_iam_role" "codebuild_role" {
  name = "codebuild-terraform-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "codebuild_ec2" {
  policy_arn = "arn:aws:iam::aws:policy/EC2FullAccess"
  role = "${aws_iam_role.codebuild_role.id}"
}

resource "aws_iam_role_policy_attachment" "codebuild_ecr" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  role = "${aws_iam_role.codebuild_role.id}"
}

resource "aws_iam_role_policy_attachment" "codebuild_s3" {
  policy_arn = "arn:aws:iam::aws:policy/S3FullAccess"
  role = "${aws_iam_role.codebuild_role.id}"
}

resource "aws_iam_role_policy_attachment" "codebuild_logs" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  role = "${aws_iam_role.codebuild_role.id}"
}

resource "aws_iam_role_policy_attachment" "codebuild_codecommit" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitReadOnly"
  role = "${aws_iam_role.codebuild_role.id}"
}

resource "aws_iam_role_policy_attachment" "codebuild_cloudformation" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCloudFormationReadOnlyAccess"
  role = "${aws_iam_role.codebuild_role.id}"
}

resource "aws_iam_role_policy_attachment" "codebuild_ssm" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadyOnlyAccess"
  role = "${aws_iam_role.codebuild_role.id}"
}

data "aws_iam_policy_document" "codebuild_kms" {
  statement {
    actions = ["kms:Decrypt"]
    resources = ["${aws_kms_key.build_params.arn}"]
  }
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name = "codebuild-terraform-policy"
  policy = "${data.aws_iam_policy_document.codebuild_kms.json}"
  role = "${aws_iam_role.codebuild_role.id}"
}



resource "aws_iam_user_policy_attachment" "build_user_iam" {
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
  user = "${aws_iam_user.build_user.id}"
}

resource "aws_iam_user_policy_attachment" "build_user_s3" {
  policy_arn = "arn:aws:iam::aws:policy/S3FullAccess"
  user = "${aws_iam_user.build_user.id}"
}

resource "aws_iam_user_policy_attachment" "build_user_ec2" {
  policy_arn = "arn:aws:iam::aws:policy/EC2FullAccess"
  user = "${aws_iam_user.build_user.id}"
}

resource "aws_iam_user_policy_attachment" "build_user_codecommit" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeCommitReadOnly"
  user = "${aws_iam_user.build_user.id}"
}
