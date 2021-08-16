provider "aws" {
  region  = var.aws_region
  profile = local.aws_profile
}

module "socks5" {
  source = "./resources"

  proxy_user     = var.proxy_user
  proxy_password = var.proxy_password

  vpc_id  = data.aws_vpc.selected.id
  subnets = data.aws_subnet_ids.selected.ids
}
