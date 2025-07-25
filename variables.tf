variable "enable_auth" {
  type        = bool
  description = "Enable Basic Authentication"
  default     = true
}

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
  default     = "default"
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

variable "allowed_networks" {
  type        = list(string)
  description = ""
}

variable "hosted_zone_name" {
  type        = string
  description = "Route53 hosted zone name"
}
