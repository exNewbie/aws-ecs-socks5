provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "socks5" {
  source = "./resources"

  aws_profile = var.aws_profile

  enable_auth    = var.enable_auth
  proxy_user     = var.proxy_user
  proxy_password = var.proxy_password

  vpc_id = data.aws_vpc.selected.id

  allowed_networks = concat(var.allowed_networks, ["${chomp(data.http.my_ip.response_body)}/32"])
}
