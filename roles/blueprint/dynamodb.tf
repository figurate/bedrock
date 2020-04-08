data "aws_iam_policy_document" "dynamodb_fullaccess" {
  statement {
    actions = [
      "dynamodb:List*",
      "dynamodb:Describe*",
      "dynamodb:Get*",
      "dynamodb:PutItem",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "dynamodb_fullaccess" {
  name        = "bedrock-dynamodb-fullaccess"
  description = "Manage DynamoDB table entries"
  policy      = data.aws_iam_policy_document.dynamodb_fullaccess.json
}
