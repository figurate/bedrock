/**
 * Synchronise image from external Docker registry.
 */
resource "null_resource" "ecr_login" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "$(aws ecr get-login --no-include-email)"
  }
}

resource "null_resource" "import" {
  count = length(var.source_tags)
  triggers = {
    //    import_enabled = var.import_enabled
  }
  provisioner "local-exec" {
    command = <<EOF
docker pull ${var.source_registry}${var.repository_name}:${var.source_tags[count.index]} \
 && docker tag ${var.source_registry}${var.repository_name}:${var.source_tags[count.index]} ${aws_ecr_repository.repository.repository_url}:${var.source_tags[count.index]} \
 && docker push ${aws_ecr_repository.repository.repository_url}:${var.source_tags[count.index]}
EOF
  }
  depends_on = [null_resource.ecr_login]
}