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


resource "aws_cloudwatch_log_group" "ecs_strapi_logs" {
  name              = "/ecs/strapi"
  retention_in_days = 7
}
