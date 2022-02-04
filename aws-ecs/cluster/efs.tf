resource "aws_efs_file_system" "efs" {
  count          = var.efs_enabled ? 1 : 0
  creation_token = local.env_string
  lifecycle_policy {
    transition_to_ia = "AFTER_14_DAYS"
  }
}

resource "aws_security_group" "efs" {
  vpc_id      = data.aws_vpc.tenant.id
  description = format("EFS filesystem access for ECS cluster: %s", local.cluster_name)
  ingress {
    description = "Allow VPC access"
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = [data.aws_vpc.tenant.cidr_block]
  }
  tags = {
    Name = format("%s-EFS", local.cluster_name)
  }
}

resource "aws_efs_mount_target" "efs" {
  for_each        = local.efs_subnets
  file_system_id  = aws_efs_file_system.efs[0].id
  subnet_id       = each.value
  security_groups = [aws_security_group.efs.id]
}
