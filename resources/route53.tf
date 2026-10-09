resource "aws_route53_record" "sock5" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "socks5.${local.country_domain}.${data.aws_route53_zone.zone.name}"
  type    = "A"
  ttl     = "10"
  records = [
    data.external.task_pub_ip.result.result
  ]
}
