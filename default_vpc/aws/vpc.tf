data aws_availability_zones "available" {
  state = "available"
}

resource aws_internet_gateway "main" {
  tags = merge(local.common_tags, {
    Name = var.name
    VPC  = var.name
  }, var.tags)

  vpc_id = aws_vpc.main.id
}

// Make our custom route table the main route table
resource aws_main_route_table_association "main" {
  route_table_id = aws_route_table.internal.id
  vpc_id         = aws_vpc.main.id
}


resource aws_route "external_igw_ipv4" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
  route_table_id         = aws_route_table.external.id
}

resource aws_route "external_igw_ipv6" {
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.main.id
  route_table_id              = aws_route_table.external.id
}

resource aws_route_table "external" {
  tags = merge(local.common_tags, {
    Name = "External ${var.name}"
    VPC  = var.name
  }, var.tags)

  vpc_id = aws_vpc.main.id
}

resource aws_route_table "internal" {
  tags = merge(local.common_tags, {
    Name = "Internal ${var.name}"
    VPC  = var.name
  }, var.tags)

  vpc_id = aws_vpc.main.id
}

resource aws_route_table_association "external" {
  count          = length(aws_subnet.external)
  route_table_id = aws_route_table.external.id
  subnet_id      = aws_subnet.external[count.index].id
}

resource aws_route_table_association "internal" {
  count          = length(aws_subnet.internal)
  route_table_id = aws_route_table.internal.id
  subnet_id      = aws_subnet.internal[count.index].id
}

resource aws_subnet "external" {
  count             = var.should_create ? length(data.aws_availability_zones.available.names) : 0
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(cidrsubnet(aws_vpc.main.cidr_block, 2, 0), 4, count.index)
  ipv6_cidr_block   = cidrsubnet(cidrsubnet(aws_vpc.main.ipv6_cidr_block, 2, 0), 6, count.index)

  tags = merge(local.common_tags, {
    Name   = "External ${data.aws_availability_zones.available.names[count.index]}"
    Subnet = data.aws_availability_zones.available.names[count.index],
    VPC    = var.name
  }, var.tags)

  vpc_id = aws_vpc.main.id
}

resource aws_subnet "internal" {
  count             = var.should_create ? length(data.aws_availability_zones.available.names) : 0
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

resource aws_vpc "main" {
  count                            = var.should_create ? 1 : 0
  assign_generated_ipv6_cidr_block = true
  cidr_block                       = var.cidr_block
  enable_dns_hostnames             = true
  enable_dns_support               = true

  tags = merge(local.common_tags, {
    Name = var.name
    VPC  = var.name
  }, var.tags)
}
