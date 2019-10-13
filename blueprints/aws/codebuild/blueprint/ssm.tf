resource "aws_kms_key" "build_params" {
  description         = "Encryption key for sensitive build parameters"
  enable_key_rotation = true
  tags {
    Consumer = "codebuild"
  }
}

resource "aws_kms_alias" "build_params" {
  target_key_id = "${aws_kms_key.build_params.id}"
  name          = "alias/blueprint-params"
}

resource "aws_ssm_parameter" "aws_access_key" {
  name        = "/blueprint/aws_access_key"
  description = "AWS access key for blueprint builds"
  type        = "SecureString"
  key_id      = "${aws_kms_key.build_params.arn}"
  value       = "${var.aws_access_key}"
  overwrite   = true
  tags {
    Consumer = "codebuild"
  }
}

resource "aws_ssm_parameter" "aws_secret_key" {
  name        = "/blueprint/aws_secret_key"
  description = "AWS access secret key for blueprint builds"
  type        = "SecureString"
  key_id      = "${aws_kms_key.build_params.arn}"
  value       = "${var.aws_secret_key}"
  overwrite   = true
  tags {
    Consumer = "codebuild"
  }
}
