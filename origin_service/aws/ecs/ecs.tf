locals {
  container_tag         = "latest"
  origin_service_name   = "origin_service"
  origin_service_memory = 512
}

resource "aws_ecs_service" "static_host" {
  lifecycle {
    ignore_changes = [desired_count]
  }

  cluster = data.terraform_remote_state.api_master.outputs.nullserve_api_ecs_cluster_arn

  deployment_controller {
    type = "ECS"
  }

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100
  desired_count                      = 1
  enable_ecs_managed_tags            = true
  health_check_grace_period_seconds  = 30
  launch_type                        = "FARGATE"

  load_balancer {
    container_name   = local.static_host_name
    target_group_arn = data.terraform_remote_state.api_master.outputs.statichost_http_alb_target_group_arn
    container_port   = 80
  }

  name = "StaticHost"

  network_configuration {
    assign_public_ip = true
    security_groups  = [data.terraform_remote_state.api_master.outputs.static_host_security_group_id]
    subnets          = data.terraform_remote_state.api_master.outputs.nullserve_api_external_subnet_ids
  }

  propagate_tags = "TASK_DEFINITION"

  tags = merge(local.common_tags)

  task_definition = aws_ecs_task_definition.static_host.arn
}

resource "aws_ecs_task_definition" "static_host" {
  container_definitions = templatefile("${path.module}/static-host-container-definitions.json.tpl", {
    name               = local.origin_service_name
    log_group          = data.terraform_remote_state.api_master.outputs.nullserve_api_static_host_cloudwatch_log_group_name
    image              = "${data.terraform_remote_state.api_master.outputs.static_host_tagged_ecr_repository_url}:${local.container_tag}"
    memory             = local.origin_service_memory
    memory_reservation = local.origin_service_memory
  })
  cpu                      = "256"
  memory                   = local.origin_service_memory
  execution_role_arn       = aws_iam_role.origin_service_execution.arn
  family                   = "OriginService"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  task_role_arn            = aws_iam_role.origin_service_task.arn

  tags = merge(local.common_tags)

}
