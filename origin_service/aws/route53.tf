resource aws_route53_zone "app" {
  comment = "NullServe Origin Service App Alias"
  name    = local.app_subdomain

  tags = merge(local.common_tags, {
    Name = "NullServe Origin Service App Alias"
  })
}

resource aws_route53_zone "ref" {
  comment = "NullServe Origin Service App Ref"
  name    = local.ref_subdomain

  tags = merge(local.common_tags, {
    Name = "NullServe Origin Service App Ref"
  })
}


resource "aws_route53_record" "app_a_wildcard" {
  alias {
    name                   = aws_lb.origin_service.dns_name
    evaluate_target_health = true
    zone_id                = aws_lb.origin_service.zone_id
  }

  name    = "*"
  type    = "A"
  zone_id = aws_route53_zone.app.zone_id
}

resource "aws_route53_record" "app_aaaa_wildcard" {
  alias {
    name                   = aws_lb.origin_service.dns_name
    evaluate_target_health = true
    zone_id                = aws_lb.origin_service.zone_id
  }

  name    = "*"
  type    = "AAAA"
  zone_id = aws_route53_zone.app.zone_id
}

resource "aws_route53_record" "app_acm_cert_validation" {
  allow_overwrite = true
  name            = aws_acm_certificate.origin_service.domain_validation_options.0.resource_record_name
  records         = [aws_acm_certificate.origin_service.domain_validation_options.0.resource_record_value]
  type            = aws_acm_certificate.origin_service.domain_validation_options.0.resource_record_type
  ttl             = 60
  zone_id         = aws_route53_zone.app.zone_id
}

resource "aws_route53_record" "ref_alias_a_wildcard" {
  alias {
    name                   = aws_lb.origin_service.dns_name
    evaluate_target_health = true
    zone_id                = aws_lb.origin_service.zone_id
  }

  name    = "*"
  type    = "A"
  zone_id = aws_route53_zone.ref.zone_id
}

resource "aws_route53_record" "ref_alias_aaaa_wildcard" {
  alias {
    name                   = aws_lb.origin_service.dns_name
    evaluate_target_health = true
    zone_id                = aws_lb.origin_service.zone_id
  }

  name    = "*"
  type    = "AAAA"
  zone_id = aws_route53_zone.ref.zone_id
}

resource "aws_route53_record" "ref_acm_cert_validation" {
  allow_overwrite = true
  name            = aws_acm_certificate.origin_service.domain_validation_options.0.resource_record_name
  records         = [aws_acm_certificate.origin_service.domain_validation_options.0.resource_record_value]
  type            = aws_acm_certificate.origin_service.domain_validation_options.0.resource_record_type
  ttl             = 60
  zone_id         = aws_route53_zone.ref.zone_id
}
