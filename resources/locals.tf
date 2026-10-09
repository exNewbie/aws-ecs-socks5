locals {
  template_file_vars = {
    proxy_user     = "/socks5/user"
    proxy_password = "/socks5/password"
  }

  region_to_domain = {
    # Asia Pacific
    "ap-southeast-1" = "sg"
    "ap-southeast-2" = "au"
    "ap-southeast-3" = "id"
    "ap-southeast-4" = "au"
    "ap-southeast-5" = "my"
    "ap-northeast-1" = "jp"
    "ap-northeast-2" = "kr"
    "ap-northeast-3" = "jp"
    "ap-south-1"     = "in"
    "ap-south-2"     = "in"
    "ap-east-1"      = "hk"

    # Americas
    "us-east-1"    = "us"
    "us-east-2"    = "us"
    "us-west-1"    = "us"
    "us-west-2"    = "us"
    "ca-central-1" = "ca"
    "ca-west-1"    = "ca"
    "sa-east-1"    = "br"

    # Europe / Middle East / Africa
    "eu-west-1"    = "ie"
    "eu-west-2"    = "uk"
    "eu-west-3"    = "fr"
    "eu-central-1" = "de"
    "eu-central-2" = "ch"
    "eu-north-1"   = "se"
    "eu-south-1"   = "it"
    "eu-south-2"   = "es"
    "me-south-1"   = "bh"
    "me-central-1" = "ae"
    "af-south-1"   = "za"
    "il-central-1" = "il"
  }

  # Usage: look up current region
  country_domain = lookup(local.region_to_domain, var.aws_region, "com")
}
