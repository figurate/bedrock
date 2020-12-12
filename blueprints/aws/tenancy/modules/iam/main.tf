module "iam_settings" {
  source = "nozaq/secure-baseline/aws//modules/iam-baseline"

  aws_account_id                  = var.aws_account_id
  support_iam_role_principal_arns = var.support_iam_role_principal_arns
}

module "iam_analyzer" {
  source = "nozaq/secure-baseline/aws//modules/analyzer-baseline"
}
