module "aws_domain" {
  domain        = var.domain
  source        = "./aws"
  should_create = var.backend == "aws"
}

module "cloudflare_domain" {
  domain        = var.domain
  source        = "./cloudflare"
  should_create = var.backend == "cloudflare"
}
