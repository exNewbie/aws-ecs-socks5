provider "aws" {
  region  = var.aws_region
  profile = local.aws_profile
}

module "socks5" {
  source = "./resources"

  enable_auth    = var.enable_auth
  proxy_user     = var.proxy_user
  proxy_password = var.proxy_password

  vpc_id = data.aws_vpc.selected.id
}
