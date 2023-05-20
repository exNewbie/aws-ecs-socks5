resource "aws_ecs_task_definition" "socks5" {
  family                = "socks5"
  container_definitions = data.template_file.socks5.rendered

  cpu    = "256" # minimum CPU
  memory = "512" # minimum memory

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  task_role_arn      = aws_iam_role.ecs_task_execution.arn
  execution_role_arn = aws_iam_role.ecs_task_execution.arn
}
