resource "aws_ecs_cluster" "strapi-cluster" {
  name = "strapi-deployment-cluster"
  tags = {
    name = "strapi-deployment-cluster"
  }
}


