module "aws_full" {
  should_create = var.backend == "aws"
  source        = "./aws"
}
