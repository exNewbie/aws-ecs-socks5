terraform {
  backend "s3" {
    bucket  = "<your-bucket>"
    region  = "ap-southeast-2"
    key     = "aws-ecs-socks5-us-east-1"
    profile = "personal"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

module "socks5" {
  source = "./resources"

  aws_profile = var.aws_profile
  aws_region  = var.aws_region

  enable_auth    = var.enable_auth
  proxy_user     = var.proxy_user
  proxy_password = var.proxy_password

  vpc_id = data.aws_vpc.selected.id

  allowed_networks = concat(var.allowed_networks, ["${chomp(data.http.my_ip.response_body)}/32"])

  hosted_zone_name = var.hosted_zone_name
}
