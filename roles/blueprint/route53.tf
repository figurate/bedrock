data "aws_iam_policy_document" "route53_additional" {
  statement {
    actions = [
      "route53:GetChange",
      "route53:GetHostedZone",
      "route53:ListTagsForResource",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "route53_zoneaccess" {
  name   = "bedrock-route53-zoneaccess"
  policy = data.aws_iam_policy_document.route53_additional.json
}
