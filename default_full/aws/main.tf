module "default_vpc" {
  backend = "aws"
  source  = "../../default_vpc"
}

module "default_log" {
  backend = "aws"
  source  = "../..default_log"
}

module "origin_service" {
  backend = "aws"
  source  = "../..origin_service"
}

module "nullserve_domain" {
  backend = "aws"
  source  = "../../nullserve_domain"
}
