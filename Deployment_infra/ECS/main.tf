resource "aws_ecs_cluster" "strapi-cluster" {
  name = "strapi-deployment-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = {
    name = "strapi-deployment-cluster"
  }
}

resource "aws_ecs_cluster_capacity_providers" "strapi-cluster-capacity" {
  cluster_name = aws_ecs_cluster.strapi-cluster.name

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }
}


resource "aws_cloudwatch_log_group" "ecs_strapi_logs" {
  name              = "/ecs/strapi"
  retention_in_days = 7
}




