data "aws_vpc" "selected" {
  default = var.vpc_id == "" ? true : false
  id      = var.vpc_id == "" ? null : var.vpc_id
}

data "http" "my_ip" {
  url = "http://ifconfig.io"
}
