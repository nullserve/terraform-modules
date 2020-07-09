resource aws_route53_record "app_subdomain_ns" {
  count   = var.should_create ? 1 : 0
  name    = local.app_subdomain
  records = aws_route53_zone.app_subdomain.0.name_servers
  ttl     = var.subdomain_ttl
  type    = "NS"
  zone_id = aws_route53_zone.domain.0.zone_id
}

resource aws_route53_record "domain_ns" {
  allow_overwrite = true
  count           = var.should_create ? 1 : 0
  name            = var.domain
  records         = aws_route53_zone.domain.0.name_servers
  ttl             = var.subdomain_ttl
  type            = "NS"
  zone_id         = aws_route53_zone.domain.0.zone_id
}

resource aws_route53_record "ref_subdomain_ns" {
  count   = var.should_create ? 1 : 0
  name    = local.ref_subdomain
  records = aws_route53_zone.ref_subdomain.0.name_servers
  ttl     = var.subdomain_ttl
  type    = "NS"
  zone_id = aws_route53_zone.domain.0.zone_id
}

resource aws_route53_zone "app_subdomain" {
  count         = var.should_create ? 1 : 0
  comment       = "NullServe Root App Subdomain"
  force_destroy = true
  name          = local.app_subdomain
  tags = merge(
    local.common_tags,
    var.tags,
    {
      "Name" = "NullServe ${local.app_subdomain} Root App Subdomain"
    }
  )
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

resource aws_route53_zone "ref_subdomain" {
  count         = var.should_create ? 1 : 0
  comment       = "NullServe Root Ref Subdomain"
  force_destroy = true
  name          = local.ref_subdomain
  tags = merge(
    local.common_tags,
    var.tags,
    {
      "Name" = "NullServe ${local.ref_subdomain} Root Ref Subdomain"
    }
  )
}
