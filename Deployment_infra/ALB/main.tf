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

resource "aws_lb_target_group" "strapi_blue_tg" {
  name        = "strapi-blue-tg"
  port        = 1337
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  deregistration_delay = "300"
  target_type = "ip"  # ✅ Required for ECS awsvpc network mode
  
  health_check {
    path                = "/admin"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  
  tags = {
    Name = "StrapiBlueTargetGroup"
  }
}


resource "aws_lb_target_group" "strapi_green_tg" {
  name        = "strapi-green-tg"
  port        = 1337
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  deregistration_delay = "300"
  target_type = "ip"  # ✅ Required for ECS awsvpc network mode
  
  health_check {
    path                = "/admin"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
  
  tags = {
    Name = "StrapiGreenTargetGroup"
  }


}




resource "aws_lb_listener" "strapi_http_listener" {
  load_balancer_arn = aws_lb.strapi_alb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type = "forward"
    forward {
      target_group {
        arn = aws_lb_target_group.strapi_blue_tg.arn
      }
    }
  }
  
  tags = {
    Name = "StrapiHTTPListener"
  }
}



