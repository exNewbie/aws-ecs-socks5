data "template_file" "socks5" {
  template = var.enable_auth ? file("${path.module}/task-definitions/socks5-auth.tpl") : file("${path.module}/task-definitions/socks5.tpl")

  vars = var.enable_auth ? local.template_file_vars : null
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_ecs_task_execution" "running_task" {
  cluster         = aws_ecs_cluster.socks5.name
  task_definition = aws_ecs_task_definition.socks5.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnets.subnets.ids
    security_groups  = [aws_security_group.socks5.id]
    assign_public_ip = true
  }
}
data "aws_route53_zone" "zone" {
  name         = var.hosted_zone_name
  private_zone = false
}

data "external" "task_pub_ip" {
  depends_on = [data.aws_ecs_task_execution.running_task]

  program = [
    "bash",
    "${path.module}/get-task-pub-ip.sh",
    var.aws_profile,
    var.aws_region,
    aws_ecs_cluster.socks5.name
  ]
}
