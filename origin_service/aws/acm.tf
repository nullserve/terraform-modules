resource aws_acm_certificate "origin_service" {
  domain_name = "*.${local.app_subdomain}"

  options {
    certificate_transparency_logging_preference = "ENABLED"
  }

  lifecycle {
    create_before_destroy = true
  }

  subject_alternative_names = [
    "*.${local.ref_subdomain}",
  ]

  tags = merge(local.common_tags, {
    Name = "NullServe Origin Service Certificate"
  })

  validation_method = "DNS"
}
