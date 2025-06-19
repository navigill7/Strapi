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
