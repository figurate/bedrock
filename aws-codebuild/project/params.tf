resource "aws_ssm_parameter" "aws_access_key" {
  name = "/terraform/aws_access_key"
  description = "AWS access key for terraform builds"
  type = "SecureString"
  key_id = "${aws_kms_key.build_params.arn}"
  value = "${var.aws_access_key}"
  overwrite = true
  tags {
    Consumer = "codebuild"
  }
}

resource "aws_ssm_parameter" "aws_secret_key" {
  name = "/terraform/aws_secret_key"
  description = "AWS access secret key for terraform builds"
  type = "SecureString"
  key_id = "${aws_kms_key.build_params.arn}"
  value = "${var.aws_secret_key}"
  overwrite = true
  tags {
    Consumer = "codebuild"
  }
}
