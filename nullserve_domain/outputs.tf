output "nullserve_domain_name_servers" {
  description = "Name Servers to be set for managing your domain."
  value = map(
    "aws", module.aws_domain.domain_name_servers,
    "cloudflare", module.cloudflare_domain.domain_name_servers.
  )[var.backend]
}
