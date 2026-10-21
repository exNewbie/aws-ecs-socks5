output "socks5_domain" {
  value = "socks5.${local.country_domain}.${data.aws_route53_zone.zone.name}"
}

