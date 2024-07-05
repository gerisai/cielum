resource "aws_route53_zone" "cielum_dns_zone" {
  name = local.domain_name

  comment = "Cielum primary hosted zone"

  tags = local.tags
}

resource "aws_route53_record" "cielum_cert_validation" {
  zone_id = aws_route53_zone.cielum_dns_zone.zone_id
  name    = var.acm_validation_dns_name
  type    = "CNAME"
  ttl     = 300
  records = [var.acm_vation_dns_value]
}

resource "aws_route53_record" "cielum_cf_record" {
  zone_id = aws_route53_zone.cielum_dns_zone.zone_id
  name    = ""
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cielum_cf_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.cielum_cf_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_acm_certificate" "cielum_certificate" {
  provider = aws.east
  domain_name       = local.domain_name
  validation_method = "DNS"
  tags = local.tags

  lifecycle {
    create_before_destroy = true
  }
}
