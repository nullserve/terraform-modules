resource aws_network_acl "external" {
  subnet_ids = aws_subnet.external.*.id

  tags = merge(local.common_tags, {
    Name = "External ${var.name}"
    VPC  = var.name
  }, var.tags)

  vpc_id = aws_vpc.main.0.id
}

resource aws_network_acl "internal" {
  subnet_ids = aws_subnet.internal.*.id

  tags = merge(local.common_tags, {
    Name = "Internal ${var.name}"
    VPC  = var.name
  }, var.tags)

  vpc_id = aws_vpc.main.0.id
}

resource aws_network_acl_rule "external_allow_all_ipv4_in" {
  cidr_block     = "0.0.0.0/0"
  egress         = false
  network_acl_id = aws_network_acl.external.id
  protocol       = -1
  rule_action    = "allow"
  rule_number    = 100
}

resource aws_network_acl_rule "external_allow_all_ipv4_out" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  network_acl_id = aws_network_acl.external.id
  protocol       = -1
  rule_action    = "allow"
  rule_number    = 100
}

resource aws_network_acl_rule "external_allow_all_ipv6_in" {
  egress          = false
  ipv6_cidr_block = "::/0"
  network_acl_id  = aws_network_acl.external.id
  protocol        = -1
  rule_action     = "allow"
  rule_number     = 101
}

resource aws_network_acl_rule "external_allow_all_ipv6_out" {
  egress          = true
  ipv6_cidr_block = "::/0"
  network_acl_id  = aws_network_acl.external.id
  protocol        = -1
  rule_action     = "allow"
  rule_number     = 101
}

resource aws_network_acl_rule "internal_allow_vpc_ipv4_in" {
  cidr_block     = aws_vpc.main.0.cidr_block
  egress         = false
  network_acl_id = aws_network_acl.internal.id
  protocol       = -1
  rule_action    = "allow"
  rule_number    = 100
}

resource aws_network_acl_rule "internal_allow_vpc_ipv4_out" {
  cidr_block     = aws_vpc.main.0.cidr_block
  egress         = true
  network_acl_id = aws_network_acl.internal.id
  protocol       = -1
  rule_action    = "allow"
  rule_number    = 100
}

resource aws_network_acl_rule "internal_allow_vpc_ipv6_in" {
  egress          = false
  ipv6_cidr_block = aws_vpc.main.0.ipv6_cidr_block
  network_acl_id  = aws_network_acl.internal.id
  protocol        = -1
  rule_action     = "allow"
  rule_number     = 101
}

resource aws_network_acl_rule "internal_allow_vpc_ipv6_out" {
  egress          = true
  ipv6_cidr_block = aws_vpc.main.0.ipv6_cidr_block
  network_acl_id  = aws_network_acl.internal.id
  protocol        = -1
  rule_action     = "allow"
  rule_number     = 101
}
