resource "aws_route53_record" "alb_cname" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.records_name
  type    = "CNAME"
  ttl     = 300
  records = [var.elb_dns_name]
}

data "aws_route53_zone" "main" {
  name         = "himanshuvk.xyz"
  private_zone = false
}