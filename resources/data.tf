data "template_file" "socks5" {
  template = var.enable_auth ? file("${path.module}/task-definitions/socks5-auth.tpl") : file("${path.module}/task-definitions/socks5.tpl")

  vars = var.enable_auth ? local.template_file_vars : null
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
