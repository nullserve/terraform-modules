resource aws_s3_bucket "access_logs" {
  acl           = "log-delivery-write"
  count         = var.should_create ? 1 : 0
  bucket_prefix = "access-logs"
  tags          = merge(local.common_tags)

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
