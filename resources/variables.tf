variable "enable_auth" {
  type        = bool
  description = "Enable Basic Authentication"
}

variable "proxy_user" {
  type        = string
  description = "Proxy Username"
  default     = ""
}

variable "proxy_password" {
  type        = string
  description = "Proxy Password"
  default     = ""
}

variable "vpc_id" {
  type = string
}

variable "allowed_networks" {
  type        = list(string)
  description = ""
  default     = ["0.0.0.0/0"]
}

variable "aws_profile" {
  type        = string
  description = "AWS profile"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "hosted_zone_name" {
  type        = string
  description = "Route53 hosted zone name"
}
