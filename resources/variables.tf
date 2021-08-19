# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

variable "proxy_user" {
  type        = string
  description = "Proxy Username"
}

variable "proxy_password" {
  type        = string
  description = "Proxy Password"
}

variable "vpc_id" {
  type = string
}

# ------------------------------------------------------------------------------
# Data
# ------------------------------------------------------------------------------

data "template_file" "socks5" {
  template = file("${path.module}/task-definitions/socks5.tpl")

  vars = {
    proxy_user     = "/socks5/user"
    proxy_password = "/socks5/password"
  }
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}