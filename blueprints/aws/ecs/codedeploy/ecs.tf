data aws_ecs_cluster ecs_cluster {
  cluster_name = local.cluster_name
}

data aws_subnet_ids vpc_subnets {
  vpc_id = data.aws_vpc.tenant.id
}

data aws_security_groups vpc_security_groups {
  vpc_ids = [data.aws_vpc.tenant.id]
}

data aws_ecr_repository service_image {
  name = var.service_image
}

data template_file task {
  template = file(format("%s/task-%s.json", var.template_path, var.task_type))
  vars = {
    ServiceName     = var.service_name
    ServiceImage    = var.service_image
    ServiceCpu      = var.service_cpu
    ServiceMemory   = var.service_memory
    ServicePort     = var.service_port
    LogRegion       = var.region
    LogGroup        = aws_cloudwatch_log_group.service_logs.name
    LogStreamPrefix = "ecs"
  }
}

resource aws_cloudwatch_log_group service_logs {
  name              = format("/ecs/%s", local.service_id)
  retention_in_days = 7
}

resource aws_ecs_task_definition service_task {
  family                = local.service_id
  network_mode          = var.network_mode
  container_definitions = data.template_file.task.rendered
}

resource aws_ecs_service service {
  name            = local.service_id
  task_definition = aws_ecs_task_definition.service_task.arn
  cluster         = data.aws_ecs_cluster.ecs_cluster.id
  desired_count   = 1
  launch_type     = var.launch_type
  network_configuration {
    subnets         = var.network_mode == "awsvpc" ? data.aws_subnet_ids.vpc_subnets.ids : null
    security_groups = var.network_mode == "awsvpc" ? data.aws_security_groups.vpc_security_groups.ids : null
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  load_balancer {
    container_name   = var.service_name
    container_port   = var.service_port
    target_group_arn = aws_lb_target_group.ecs_blue.arn
  }
}
