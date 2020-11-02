// TODO: Split this into a secondary module to allow cross-provider DNS?
data "aws_route53_zone" "domain" {
  zone_id = var.domain_zone_id
}

// TODO: Split this into a secondary module to allow cross-provider DNS?
resource "aws_route53_record" "subdomain" {
  allow_overwrite = true
  name            = var.subdomain_prefix
  records         = aws_route53_zone.sites_zone.name_servers
  ttl             = 24 * 60 * 60
  type            = "NS"
  zone_id         = data.aws_route53_zone.domain.zone_id
}

resource "aws_route53_zone" "subdomain" {
  name    = var.subdomain_prefix
  comment = "Subdomain ${var.subdomain} for NullServe"

  // TODO: Add tags
}
