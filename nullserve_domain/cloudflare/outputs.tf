output "domain_name_servers" {
  value = var.should_create ? cloudflare_zone.domain.0.name_servers : null
}
