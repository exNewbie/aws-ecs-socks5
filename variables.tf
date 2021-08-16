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
  dynamic "select_vpc" {
    for_each = var.vpc_id == "" ? 1 : 0
    content {
      default = true
    }
  }

  dynamic "select_vpc" {
    for_each = var.vpc_id == "" ? 0 : 1
    content {
      default = false
      id      = var.vpc_id
    }
  }
}

data "aws_subnet_ids" "selected" {
  count  = var.vpc_id == "" ? 0 : 1
  vpc_id = data.aws_vpc.selected.id

  dynamic "select_vpc" {
    for_each = var.vpc_id == "" ? 1 : 0
    content {
      vpc_id = data.aws_vpc.default.id
    }
  }

  dynamic "select_vpc" {
    for_each = var.vpc_id == "" ? 0 : 1
    content {
      vpc_id = var.vpc_id

      filter {
        name   = "tag:Name"
        values = ["*${subnet_keyword}*"]
      }
    }
  }
}
