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

variable "subnets" {
  type        = list(any)
  description = "Subnets that the task will run on"
}

# ------------------------------------------------------------------------------
# Data
# ------------------------------------------------------------------------------

data "template_file" "socks5" {
  template = file("${path.module}/task-definitions/socks5.tpl")

  vars = {
    proxy_user     = var.proxy_user
    proxy_password = var.proxy_password
  }
}
