data "aws_iam_role" ecs_deploy {
  name = "bedrock-ecs-codedeploy"
}

data aws_vpc tenant {
  default = var.vpc_default
  tags    = var.vpc_tags
}

data "aws_lb" ecs_cluster {
  name = "${local.cluster_name}-alb"
}

data aws_lb_listener ecs_blue {
  load_balancer_arn = data.aws_lb.ecs_cluster.arn
  port              = 443
}

data aws_lb_listener ecs_green {
  load_balancer_arn = data.aws_lb.ecs_cluster.arn
  port              = 8443
}

resource aws_lb_target_group ecs_blue {
  deregistration_delay = 0
  health_check {
    interval            = 60
    unhealthy_threshold = 10
    path                = "/"
    matcher             = "200"
  }
  port        = var.service_port
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.tenant.id
  name        = local.service_id
  target_type = var.launch_type == "FARGATE" ? "ip" : "instance"
}

resource "aws_lb_listener_rule" ecs_blue {
  listener_arn = data.aws_lb_listener.ecs_blue.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_blue.arn
  }
  condition {
    field  = "host-header"
    values = []
  }
}

resource aws_lb_target_group ecs_green {
  deregistration_delay = 0
  health_check {
    interval            = 60
    unhealthy_threshold = 10
    path                = "/"
    matcher             = "200"
  }
  port        = var.service_port
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.tenant.id
  name        = format("green-%s", local.service_id)
  target_type = var.launch_type == "FARGATE" ? "ip" : "instance"
}

resource "aws_lb_listener_rule" ecs_green {
  listener_arn = data.aws_lb_listener.ecs_green.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_green.arn
  }
  condition {
    field  = "host-header"
    values = []
  }
}

resource aws_codedeploy_app ecs_deploy {
  name             = local.service_id
  compute_platform = "ECS"
}

resource aws_codedeploy_deployment_group service_deploy_group {
  app_name               = aws_codedeploy_app.ecs_deploy.name
  deployment_group_name  = local.service_id
  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"
  service_role_arn       = data.aws_iam_role.ecs_deploy.arn

  blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }
    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }

  ecs_service {
    cluster_name = local.cluster_name
    service_name = aws_ecs_service.service.name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [data.aws_lb_listener.ecs_blue.arn]
      }
      target_group {
        name = aws_lb_target_group.ecs_blue.name
      }
      target_group {
        name = aws_lb_target_group.ecs_green.name
      }
    }
  }
}
