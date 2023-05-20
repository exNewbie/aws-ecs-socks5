resource "aws_ssm_parameter" "user" {
  count = var.enable_auth ? 1 : 0

  name  = "/socks5/user"
  type  = "SecureString"
  value = var.proxy_user
}

resource "aws_ssm_parameter" "password" {
  count = var.enable_auth ? 1 : 0

  name  = "/socks5/password"
  type  = "SecureString"
  value = var.proxy_password
}