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
  depends_on = [
    aws_ecs_cluster.socks5
  ]

  program = [
    "/bin/bash",
    "${path.module}/scripts/count-tasks.sh",
    var.aws_profile
  ]

  query = {
    cluster_name = "socks5"
    aws_region   = data.aws_region.current.name
  }
}

