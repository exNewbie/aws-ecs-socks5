resource "aws_ssm_parameter" "user" {
  name  = "/socks5/user"
  type  = "SecureString"
  value = var.proxy_user
}

resource "aws_ssm_parameter" "password" {
  name  = "/socks5/password"
  type  = "SecureString"
  value = var.proxy_password
}