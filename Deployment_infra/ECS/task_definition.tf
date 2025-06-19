resource "aws_ecs_task_definition" "TD" {
  family                   = "medusa-service"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "4096"
  memory                   = "8192"
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([
    {
      name      = "strapi"
      image     = "gillnavi/strapi:f46644652b39301ac54f76831bc6551dc0d1f59e"
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
          awslogs-group         = "/ecs/strapi"
          awslogs-region        = "us-east-1"
          awslogs-stream-prefix = "strapi"
        }
      }
    }
  ])

  lifecycle {
    create_before_destroy = true
  }
}
