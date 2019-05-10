data "aws_iam_policy_document" "kms_additional" {
  statement {
    actions = [
      "kms:UpdateKeyDescription",
      "kms:EnableKeyRotation",
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "kms_encryption" {
  statement {
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "kms_keymanagement" {
  name = "bedrock-kms-keymanagement"
  policy = "${data.aws_iam_policy_document.kms_additional.json}"
}

resource "aws_iam_policy" "kms_encryption" {
  name = "bedrock-kms-encryption"
  policy = "${data.aws_iam_policy_document.kms_encryption.json}"
}
