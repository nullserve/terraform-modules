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

resource aws_route53_zone "app_subdomain" {
  count         = var.should_create ? 1 : 0
  comment       = "NullServe Root App Subdomain"
  force_destroy = true
  name          = "${var.app_prefix}.${var.domain}"
  tags = merge(
    local.common_tags,
    var.tags,
    {
      "Name" = "NullServe ${var.app_prefix}.${var.domain} Root App Subdomain"
    }
  )
}

resource aws_route53_zone "ref_subdomain" {
  count         = var.should_create ? 1 : 0
  comment       = "NullServe Root Ref Subdomain"
  force_destroy = true
  name          = "${var.ref_prefix}.${var.domain}"
  tags = merge(
    local.common_tags,
    var.tags,
    {
      "Name" = "NullServe ${var.ref_prefix}.${var.domain} Root Ref Subdomain"
    }
  )
}
