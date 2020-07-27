output "external_subnet_ids" {
  value = aws_subnet.external.*.id
}

output "internal_subnet_ids" {
  value = aws_subnet.internal.*.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}
