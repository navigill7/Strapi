resource "aws_codedeploy_app" "strapi" {
  name             = "strapi-codedeploy"
  compute_platform = "ECS"
}
