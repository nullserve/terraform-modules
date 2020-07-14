locals {
  common_tags = {
    Application = var.name
    Stack       = var.stack_name
    IsTerraform = "true"
    IsNullServe = "true"
  }
}
