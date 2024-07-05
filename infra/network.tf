
resource "aws_cloudfront_origin_access_control" "cielum_ac" {
  name                              = "Cielum AC"
  description                       = "Cielum AC Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cielum_cf_distribution" {
  origin {
    domain_name              = aws_s3_bucket.cielum_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.cielum_ac.id
    origin_id                = local.origin_id
  }

  comment             = "Cielum CF distribution"
  aliases             = [local.domain_name]
  enabled             = true
  default_root_object = "index.html"
  price_class         = "PriceClass_100" # Only Mexico, USA and Canada

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "MX"]
    }
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.cielum_certificate.arn
    ssl_support_method = "sni-only"
  }

  default_cache_behavior {
    allowed_methods        = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    cache_policy_id        = local.cache_policy_id
    target_origin_id       = local.origin_id
    viewer_protocol_policy = "redirect-to-https"
  }

  tags = local.tags
}