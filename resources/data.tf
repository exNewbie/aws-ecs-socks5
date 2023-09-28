data "template_file" "socks5" {
  template = var.enable_auth ? file("${path.module}/task-definitions/socks5-auth.tpl") : file("${path.module}/task-definitions/socks5.tpl")

  vars = var.enable_auth ? local.template_file_vars : null
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "external" "count_tasks" {
  program = ["/bin/bash", "${path.module}/scripts/count-tasks.sh"]

  query = {
    cluster_name = "socks5"
    aws_region   = data.aws_region.current.name
  }
}

data "aws_ecs_task_execution" "socks5" {
  count = data.external.count_tasks.result["count"] > 0 ? 0 : 1

  cluster         = aws_ecs_cluster.socks5.id
  task_definition = aws_ecs_task_definition.socks5.arn
  desired_count   = 1

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
  }

  network_configuration {
    subnets          = data.aws_subnets.subnets.ids
    security_groups  = [aws_security_group.socks5.id]
    assign_public_ip = true
  }
}
