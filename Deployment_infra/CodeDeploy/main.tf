resource "aws_codedeploy_app" "strapi" {
  name             = "strapi-codedeploy"
  compute_platform = "ECS"
}

resource "aws_codedeploy_deployment_group" "strapi" {
  app_name              = aws_codedeploy_app.strapi.name
  deployment_group_name = "strapi-deploy-group"
  service_role_arn      = var.codedeploy_role_arn

  deployment_config_name = "CodeDeployDefault.ECSCanary10Percent5Minutes"

  ecs_service {
    cluster_name = var.cluster_name       # e.g., "strapi-bluegreen-cluster"
    service_name = var.service_name       # e.g., "strapi-service"
  }

  deployment_style {
    deployment_type   = "BLUE_GREEN"
    deployment_option = "WITH_TRAFFIC_CONTROL"
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [var.listener_arn] # Must be a list
      }

      target_group {
        name = var.blue_tg_name  # e.g., "strapi-blue-tg"
      }

      target_group {
        name = var.green_tg_name # e.g., "strapi-green-tg"
      }
    }
  }

  blue_green_deployment_config {
    terminate_blue_instances_on_deployment_success {
      action                         = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }

    deployment_ready_option {
      action_on_timeout   = "CONTINUE_DEPLOYMENT"
      wait_time_in_minutes = 0
    }

    green_fleet_provisioning_option {
      action = "DISCOVER_EXISTING"
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }
}
