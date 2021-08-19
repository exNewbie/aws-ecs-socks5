resource "aws_security_group" "socks5" {
  name        = "socks5"
  description = "Allow Socks 5 inbound traffic"
  vpc_id      = var.vpc_id

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "sg-socks5"
  }
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.socks5.id
}

resource "aws_security_group_rule" "socks5" {
  security_group_id = aws_security_group.socks5.id
  type              = "ingress"
  from_port         = "1080"
  to_port           = "1080"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
