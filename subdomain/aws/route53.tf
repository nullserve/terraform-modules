// TODO: Split this into a secondary module to allow cross-provider DNS?
data "aws_route53_zone" "domain" {
  name = var.root_domain
}

// TODO: Split this into a secondary module to allow cross-provider DNS?
resource "aws_route53_record" "subdomain" {
  allow_overwrite = true
  name            = var.subdomain_prefix
  records         = aws_route53_zone.subdomain.name_servers
  ttl             = 24 * 60 * 60
  type            = "NS"
  zone_id         = data.aws_route53_zone.domain.zone_id
}

resource "aws_route53_zone" "subdomain" {
  name    = "${var.subdomain_prefix}.${data.aws_route53_zone.domain.name}"
  comment = "Subdomain ${var.subdomain_prefix} for NullServe"

  tags = merge(
    local.common_tags,
    var.tags,
    {
      "Name" = "NullServe ${var.subdomain_prefix} Subdomain"
    }
  )
}
