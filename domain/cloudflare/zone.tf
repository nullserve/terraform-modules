resource cloudflare_zone "domain" {
  count = var.should_create ? 1 : 0
  zone  = var.domain
}
