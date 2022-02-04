resource "aws_cloudwatch_log_group" "log" {
  name              = "ecs/${var.name}"
  retention_in_days = 14
}

module "task_definition" {
  source = "figurate/ecs-task-definition/aws"

  execution_role   = null
  image            = var.image
  image_tag        = var.image_tag
  cpu              = var.cpu
  memory           = var.memory
  log_group        = aws_cloudwatch_log_group.log.name
  ports            = var.ports
  network_mode     = var.network_mode
  task_role        = "ecs-task-role"
  namespace        = var.namespace
  name             = var.name
  type             = "default"
  health_check     = var.health_check
  volumes          = var.volumes
  mounts           = var.mounts
  task_environment = var.task_environment
  docker_labels    = var.docker_labels
}
