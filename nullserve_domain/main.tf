module "aws_nullserve_domain" {
  domain        = var.domain
  source        = "./aws"
  should_create = var.backend == "aws"
}

module "cloudflare_nullserve_domain" {
  domain        = var.domain
  source        = "./cloudflare"
  should_create = var.backend == "cloudflare"
}
