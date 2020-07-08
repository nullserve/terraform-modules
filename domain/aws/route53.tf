resource aws_route53_zone "domain" {
  count         = var.should_create ? 1 : 0
  comment       = "NullServe Root Domain"
  force_destroy = true
  name          = "aws.0srv.co"
  tags          = merge(local.common_tags, var.tags)
}
