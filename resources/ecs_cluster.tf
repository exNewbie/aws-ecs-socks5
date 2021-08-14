resource "aws_ecs_cluster" "socks5" {
  # In order to ensure the container is able to create, add FARGATE to capacity_providers
  capacity_providers = ["FARGATE_SPOT"]
  name               = "socks5"

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}
