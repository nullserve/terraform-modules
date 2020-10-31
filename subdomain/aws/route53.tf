resource "aws_route53_zone" "subdomain" {
  name = var.subdomain_prefix
}