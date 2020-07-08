locals {
  app_subdomain = "${var.app_prefix}.${var.domain}"
  common_tags = {
    Application = var.name
    Stack       = var.stack_name
    IsTerraform = "true"
    IsNullServe = "true"
  }
  ref_subdomain = "${var.ref_prefix}.${var.domain}"
}
