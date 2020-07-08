module "aws_domain" {
  domain        = "aws.0srv.co"
  source        = "./aws"
  should_create = var.backend == "aws"
}
