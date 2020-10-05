module "aws_default_log" {
  source        = "./aws"
  should_create = var.backend == "aws"
}
