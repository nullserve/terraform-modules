output "bucket_id" {
  value = aws_s3_bucket.access_logs.0.id
}

output "bucket_arn" {
  value = aws_s3_bucket.access_logs.0.arn
}
