resource "aws_security_group" "origin_service" {
  description            = "Contains Origin Service Server"
  name_prefix            = "nullserve-api-origin-service"
  revoke_rules_on_delete = true
  vpc_id                 = var.vpc_id

  tags = merge(local.common_tags, {
    Name : "NullServe API Static Host",
    VPC : "NullServe API"
  })

}

resource "aws_security_group" "origin_service_elb" {
  description            = "Contains Static Host Server ELBv2"
  name_prefix            = "nullserve-api-origin-service-elb"
  revoke_rules_on_delete = true
  vpc_id                 = var.vpc_id

  tags = merge(local.common_tags, {
    Name : "NullServe API Static Host ELB",
    VPC : "NullServe API"
  })
}

resource "aws_security_group_rule" "origin_service_egress_http_elb" {
  description              = "HTTP to elb"
  from_port                = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.origin_service.id
  source_security_group_id = aws_security_group.origin_service_elb.id
  to_port                  = 80
  type                     = "egress"
}

resource "aws_security_group_rule" "origin_service_control_egress_http_elb" {
  description              = "HTTP to elb"
  from_port                = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.origin_service.id
  source_security_group_id = aws_security_group.origin_service_elb.id
  to_port                  = 8080
  type                     = "egress"
}

resource "aws_security_group_rule" "origin_service_egress_https_elb" {
  description              = "HTTPS to elb"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.origin_service.id
  source_security_group_id = aws_security_group.origin_service_elb.id
  to_port                  = 443
  type                     = "egress"
}

resource "aws_security_group_rule" "origin_service_egress_http3_elb" {
  description              = "QUIC HTTP3 to elb"
  from_port                = 443
  protocol                 = "udp"
  security_group_id        = aws_security_group.origin_service.id
  source_security_group_id = aws_security_group.origin_service_elb.id
  to_port                  = 443
  type                     = "egress"
}

resource "aws_security_group_rule" "origin_service_egress_https" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]

  description = "HTTPS to all sources"
  from_port   = 443

  ipv6_cidr_blocks = [
    "::/0",
  ]

  protocol          = "tcp"
  security_group_id = aws_security_group.origin_service.id
  to_port           = 443
  type              = "egress"
}

resource "aws_security_group_rule" "origin_service_egress_http3" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]

  description = "QUIC HTTP3 to all sources"
  from_port   = 443

  ipv6_cidr_blocks = [
    "::/0",
  ]

  protocol          = "udp"
  security_group_id = aws_security_group.origin_service.id
  to_port           = 443
  type              = "egress"
}

resource "aws_security_group_rule" "origin_service_ingress_http_elb" {
  description              = "HTTP from elb"
  from_port                = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.origin_service.id
  source_security_group_id = aws_security_group.origin_service_elb.id
  to_port                  = 80
  type                     = "ingress"
}

resource "aws_security_group_rule" "origin_service_control_ingress_http_elb" {
  description              = "HTTP from elb"
  from_port                = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.origin_service.id
  source_security_group_id = aws_security_group.origin_service_elb.id
  to_port                  = 8080
  type                     = "ingress"
}

resource "aws_security_group_rule" "origin_service_ingress_https_elb" {
  description              = "HTTPS from elb"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.origin_service.id
  source_security_group_id = aws_security_group.origin_service_elb.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "origin_service_ingress_http3_elb" {
  description              = "QUIC HTTP3 from elb"
  from_port                = 443
  protocol                 = "udp"
  security_group_id        = aws_security_group.origin_service.id
  source_security_group_id = aws_security_group.origin_service_elb.id
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_security_group_rule" "origin_service_elb_egress_http_elb" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]

  description = "HTTP to all sources"
  from_port   = 80

  ipv6_cidr_blocks = [
    "::/0",
  ]

  protocol          = "tcp"
  security_group_id = aws_security_group.origin_service_elb.id
  to_port           = 80
  type              = "egress"
}

resource "aws_security_group_rule" "origin_service_elb_control_egress_http_elb" {
  description              = "HTTP to elb"
  from_port                = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.origin_service_elb.id
  source_security_group_id = aws_security_group.origin_service.id
  to_port                  = 8080
  type                     = "egress"
}

resource "aws_security_group_rule" "origin_service_elb_egress_https_elb" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]

  description = "HTTPS to all sources"
  from_port   = 443

  ipv6_cidr_blocks = [
    "::/0",
  ]

  protocol          = "tcp"
  security_group_id = aws_security_group.origin_service_elb.id
  to_port           = 443
  type              = "egress"
}

resource "aws_security_group_rule" "origin_service_elb_egress_http3_elb" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]

  description = "QUIC HTTP3 to all sources"
  from_port   = 443

  ipv6_cidr_blocks = [
    "::/0",
  ]

  protocol          = "udp"
  security_group_id = aws_security_group.origin_service_elb.id
  to_port           = 443
  type              = "egress"
}

resource aws_security_group_rule "origin_service_elb_ingress_http_elb" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]

  description = "HTTP from all sources"
  from_port   = 80

  ipv6_cidr_blocks = [
    "::/0",
  ]

  protocol          = "tcp"
  security_group_id = aws_security_group.origin_service_elb.id
  to_port           = 80
  type              = "ingress"
}

resource aws_security_group_rule "origin_service_elb_ingress_https_elb" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]

  description = "HTTPS from all sources"
  from_port   = 443

  ipv6_cidr_blocks = [
    "::/0",
  ]

  protocol          = "tcp"
  security_group_id = aws_security_group.origin_service_elb.id
  to_port           = 443
  type              = "ingress"
}

resource aws_security_group_rule "origin_service_elb_ingress_http3_elb" {
  cidr_blocks = [
    "0.0.0.0/0",
  ]

  description = "QUIC HTTP3 from all sources"
  from_port   = 443

  ipv6_cidr_blocks = [
    "::/0",
  ]

  protocol          = "udp"
  security_group_id = aws_security_group.origin_service_elb.id
  to_port           = 443
  type              = "ingress"
}
