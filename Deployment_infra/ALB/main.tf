resource "aws_lb" "strapi_alb" {
  name               = "strapi-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = var.public_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name = "StrapiALB"
  }
  
}

resource "aws_lb_target_group" "strapi_target_group" {
  name        = "strapi-target-group"
  port        = 1337
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  deregistration_delay = "300"
  target_type = "ip"  # ✅ Added this line - required for ECS awsvpc network mode

  health_check {
    path                = "/admin"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "StrapiTargetGroup"
  }
  
}

# Commented out since you're using ECS, not EC2 instances
# resource "aws_lb_target_group_attachment" "strapi_target_group_attachment" {
#   count              = length(var.strapi_instance_ids)
#   target_group_arn   = aws_lb_target_group.strapi_target_group.arn
#   target_id          = var.strapi_instance_ids[count.index]
#   port               = 1337
# }

resource "aws_lb_listener" "strapi_http_listener" {
  load_balancer_arn = aws_lb.strapi_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.strapi_target_group.arn
  }

  tags = {
    Name = "StrapiHTTPListener"
  }
  
}