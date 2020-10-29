resource aws_route53_record "domain_ns" {
  allow_overwrite = true
  count           = var.should_create ? 1 : 0
  name            = var.domain
  records         = aws_route53_zone.domain.0.name_servers
  ttl             = var.ttl
  type            = "NS"
  zone_id         = aws_route53_zone.domain.0.zone_id
}

resource aws_route53_zone "domain" {
  count         = var.should_create ? 1 : 0
  comment       = "NullServe Root Domain"
  force_destroy = true
  name          = var.domain
  tags = merge(
    local.common_tags,
    var.tags,
    {
      "Name" = "NullServe ${var.domain} Root Domain"
    }
  )
}

