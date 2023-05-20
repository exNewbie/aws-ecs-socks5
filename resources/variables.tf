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
