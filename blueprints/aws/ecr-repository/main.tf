module "repository" {
  source = "figurate/ecr-repository/aws"

  name                       = var.name
  scan_on_push               = var.scan_on_push
  untagged_image_expiry_days = var.untagged_image_expiry_days
}

module "import" {
  count  = var.import_enabled ? length(var.source_tags) : 0
  source = "figurate/docker-container/docker//modules/ecr"

  name       = "${var.name}_push_${var.source_tags[count.index]}"
  command    = ["push", var.name, var.source_tags[count.index], var.source_tags[count.index]]
  depends_on = [module.repository]
  rm         = true
  aws_region = var.aws_region
}
