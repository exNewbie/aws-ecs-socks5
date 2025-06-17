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

resource "null_resource" "run_task" {
  triggers = {
    task_definition = aws_ecs_task_definition.socks5.arn
  }

  provisioner "local-exec" {
    command = <<EOF
      aws ecs run-task \
        --profile ${var.aws_profile} \
        --region ${var.aws_region} \
        --cluster ${aws_ecs_cluster.socks5.name} \
        --task-definition ${aws_ecs_task_definition.socks5.arn} \
        --launch-type FARGATE \
        --network-configuration "awsvpcConfiguration={subnets=[${join(",", data.aws_subnets.subnets.ids)}],securityGroups=[${aws_security_group.socks5.id}],assignPublicIp=ENABLED}"
    EOF
  }
}

