data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_internet_gateway" "main" {
  tags = merge(var.tags, {
    Name = var.name
    VPC  = var.name
  })

  vpc_id = aws_vpc.main.id
}

// Make our custom route table the main route table
resource "aws_main_route_table_association" "main" {
  route_table_id = aws_route_table.internal.id
  vpc_id         = aws_vpc.main.id
}

resource "aws_network_acl" "external" {
  subnet_ids = aws_subnet.external.*.id

  tags = merge(var.tags, {
    Name = "External ${var.name}"
    VPC  = var.name
  })

  vpc_id = aws_vpc.main.id
}

resource "aws_network_acl" "internal" {
  subnet_ids = aws_subnet.internal.*.id

  tags = merge(var.tags, {
    Name = "Internal ${var.name}"
    VPC  = var.name
  })

  vpc_id = aws_vpc.main.id
}

resource "aws_network_acl_rule" "external_allow_all_ipv4_in" {
  cidr_block     = "0.0.0.0/0"
  egress         = false
  network_acl_id = aws_network_acl.external.id
  protocol       = -1
  rule_action    = "allow"
  rule_number    = 100
}

resource "aws_network_acl_rule" "external_allow_all_ipv4_out" {
  cidr_block     = "0.0.0.0/0"
  egress         = true
  network_acl_id = aws_network_acl.external.id
  protocol       = -1
  rule_action    = "allow"
  rule_number    = 100
}

resource "aws_network_acl_rule" "external_allow_all_ipv6_in" {
  egress          = false
  ipv6_cidr_block = "::/0"
  network_acl_id  = aws_network_acl.external.id
  protocol        = -1
  rule_action     = "allow"
  rule_number     = 101
}

resource "aws_network_acl_rule" "external_allow_all_ipv6_out" {
  egress          = true
  ipv6_cidr_block = "::/0"
  network_acl_id  = aws_network_acl.external.id
  protocol        = -1
  rule_action     = "allow"
  rule_number     = 101
}

resource "aws_network_acl_rule" "internal_allow_vpc_ipv4_in" {
  cidr_block     = aws_vpc.main.cidr_block
  egress         = false
  network_acl_id = aws_network_acl.internal.id
  protocol       = -1
  rule_action    = "allow"
  rule_number    = 100
}

resource "aws_network_acl_rule" "internal_allow_vpc_ipv4_out" {
  cidr_block     = aws_vpc.main.cidr_block
  egress         = true
  network_acl_id = aws_network_acl.internal.id
  protocol       = -1
  rule_action    = "allow"
  rule_number    = 100
}

resource "aws_network_acl_rule" "internal_allow_vpc_ipv6_in" {
  egress          = false
  ipv6_cidr_block = aws_vpc.main.ipv6_cidr_block
  network_acl_id  = aws_network_acl.internal.id
  protocol        = -1
  rule_action     = "allow"
  rule_number     = 101
}

resource "aws_network_acl_rule" "internal_allow_vpc_ipv6_out" {
  egress          = true
  ipv6_cidr_block = aws_vpc.main.ipv6_cidr_block
  network_acl_id  = aws_network_acl.internal.id
  protocol        = -1
  rule_action     = "allow"
  rule_number     = 101
}

resource "aws_route" "external_igw_ipv4" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
  route_table_id         = aws_route_table.external.id
}

resource "aws_route" "external_igw_ipv6" {
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.main.id
  route_table_id              = aws_route_table.external.id
}

resource "aws_route_table" "external" {
  tags = merge(var.tags, {
    Name = "External ${var.name}"
    VPC  = var.name
  })

  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "internal" {
  tags = merge(var.tags, {
    Name = "Internal ${var.name}"
    VPC  = var.name
  })

  vpc_id = aws_vpc.main.id
}

resource "aws_route_table_association" "external" {
  count          = length(aws_subnet.external)
  route_table_id = aws_route_table.external.id
  subnet_id      = aws_subnet.external[count.index].id
}

resource "aws_route_table_association" "internal" {
  count          = length(aws_subnet.internal)
  route_table_id = aws_route_table.internal.id
  subnet_id      = aws_subnet.internal[count.index].id
}

resource "aws_subnet" "external" {
  count             = length(data.aws_availability_zones.available.names)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(cidrsubnet(aws_vpc.main.cidr_block, 2, 0), 4, count.index)
  ipv6_cidr_block   = cidrsubnet(cidrsubnet(aws_vpc.main.ipv6_cidr_block, 2, 0), 6, count.index)

  tags = merge(var.tags, {
    Name   = "External ${data.aws_availability_zones.available.names[count.index]}"
    Subnet = data.aws_availability_zones.available.names[count.index],
    VPC    = var.name
  })

  vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "internal" {
  count             = length(data.aws_availability_zones.available.names)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(cidrsubnet(aws_vpc.main.cidr_block, 2, 1), 4, count.index)
  ipv6_cidr_block   = cidrsubnet(cidrsubnet(aws_vpc.main.ipv6_cidr_block, 2, 1), 6, count.index)

  tags = merge(var.tags, {
    Name   = "Internal ${data.aws_availability_zones.available.names[count.index]}"
    Subnet = data.aws_availability_zones.available.names[count.index],
    VPC    = var.name
  })

  vpc_id = aws_vpc.main.id
}

resource "aws_vpc" "main" {
  assign_generated_ipv6_cidr_block = true
  cidr_block                       = var.cidr_block
  enable_dns_hostnames             = true
  enable_dns_support               = true

  tags = merge(var.tags, {
    Name = var.name
    VPC  = var.name
  })
}
