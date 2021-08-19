# ------------------------------------------------------------------------------
# Local Variables
# ------------------------------------------------------------------------------

locals {
  aws_profile = var.aws_profile == "" ? "default" : var.aws_profile
}

# ------------------------------------------------------------------------------
# Variables
# ------------------------------------------------------------------------------

variable "proxy_user" {
  type        = string
  description = "Proxy Username"
}

variable "proxy_password" {
  type        = string
  description = "Proxy Password"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "aws_profile" {
  type        = string
  description = "AWS profile"
  default     = ""
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "subnet_keyword" {
  type        = string
  description = "Key word of Subnets"
  default     = ""
}

# ------------------------------------------------------------------------------
# Data
# ------------------------------------------------------------------------------

data "aws_vpc" "selected" {
  default = var.vpc_id == "" ? true : false
  id      = var.vpc_id == "" ? null : var.vpc_id
}

data "aws_subnet_ids" "selected" {
  vpc_id = data.aws_vpc.selected.id

  # dynamic "filter" {
  #   for_each = var.vpc_id == "" ? 0 : 1
  #   content {
  #     filter {
  #       name   = "tag:Name"
  #       values = ["*${subnet_keyword}*"]
  #     }
  #   }
  # }
}
