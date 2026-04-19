resource "aws_route53_record" "sock5" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = "socks5.${substr(var.aws_region, 0, 2)}.${data.aws_route53_zone.zone.name}"
  type    = "A"
  ttl     = "10"
  records = [
    data.external.task_pub_ip.result.result
  ]
}
