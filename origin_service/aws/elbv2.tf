data "aws_elb_service_account" "main" {}

resource "aws_lb" "origin_service" {
  access_logs {
    bucket  = var.access_log_bucket
    prefix  = var.elb_origin_service_access_logging_prefix
    enabled = false
  }

  enable_deletion_protection = true
  enable_http2               = true
  idle_timeout               = 60
  internal                   = false
  ip_address_type            = "dualstack"
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.origin_service_elb.id]
  subnets                    = var.external_subnet_ids

  tags = merge(local.common_tags, {
    Name = "NullServe Origin Service Load Balancer"
  })
}

resource "aws_lb_listener" "origin_service_http" {
  default_action {
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }

    type = "redirect"
  }

  load_balancer_arn = aws_lb.origin_service.arn
  port              = 80
  protocol          = "HTTP"
}

resource "aws_lb_listener" "origin_service_https" {
  certificate_arn = aws_acm_certificate.origin_service.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.origin_service_http.arn
  }

  load_balancer_arn = aws_lb.origin_service.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-Ext-2018-06"
}

resource "aws_lb_target_group" "origin_service_http" {
  health_check {
    path                = "/health"
    port                = 8080
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200,202,204"
  }

  port        = 80
  protocol    = "HTTP"
  target_type = "ip"

  tags = merge(local.common_tags, {
    Name = "NullServe Origin Service HTTP Target Group"
  })

  vpc_id = var.vpc_id
}
