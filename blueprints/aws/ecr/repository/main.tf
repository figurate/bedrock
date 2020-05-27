/**
 * # ECR Repository Creation
 *
 * Create an ECR repository with lifecycle rules.
 */
module "repository" {
  source = "figurate/ecr-repository/aws"

  name                       = var.repository_name
  scan_on_push               = var.scan_on_push
  untagged_image_expiry_days = var.image_expiry
  source_registry            = var.source_registry
  source_tags                = var.source_tags
  import_frequency           = var.import_frequency
}
