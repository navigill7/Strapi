resource "aws_ecs_service" "strapi-cluster-service" {
  name            = "cluster-service"
  cluster         = aws_ecs_cluster.strapi-cluster.id
  task_definition = aws_ecs_task_definition.TD.arn
  desired_count   = 2

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "strapi"
    container_port   = 1337
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}
