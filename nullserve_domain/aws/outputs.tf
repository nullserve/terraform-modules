output "domain_name_servers" {
  value = var.should_create ? aws_route53_zone.domain.0.name_servers : null
}
