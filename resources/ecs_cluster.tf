resource "aws_ecs_cluster" "socks5" {
  # In order to ensure the container is able to create, add FARGATE to capacity_providers
  capacity_providers = ["FARGATE_SPOT"]
  name               = "socks5"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }

  network_configuration {
    subnets          = var.subnets
    security_groups  = [aws_security_group.socks5.id]
    assign_public_ip = true
  }
}

resource "aws_security_group" "socks5" {
  name        = "sg_socks5"
  description = "Allow Socks 5 inbound traffic"
  vpc_id      = var.vpc_id

  ingress = [
    {
      description      = "TLS from VPC"
      from_port        = 1080
      to_port          = 1080
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  ]
}