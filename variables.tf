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

