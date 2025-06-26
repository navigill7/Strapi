resource "aws_ecs_task_definition" "TD" {
  family                   = "strapi-service"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "4096"
  memory                   = "8192"
  execution_role_arn       = var.execution_role_arn
  container_definitions = jsonencode([
    {
      name  = "strapi"
      image = "647198474080.dkr.ecr.us-east-1.amazonaws.com/strapi-artifacts:430b575074eb848bd9502271f55b7162ba33f2f2"
      essential = true
      portMappings = [
        {
          containerPort = 1337
          hostPort      = 1337
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/strapi"
          "awslogs-region"        = "us-east-1"
          "awslogs-stream-prefix" = "strapi"
          "awslogs-create-group"  = "true"
        }
      }
    }
  ])

  lifecycle {
    create_before_destroy = true
  }
}





