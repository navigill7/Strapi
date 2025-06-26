output "target_group_arn" {
  value       = aws_lb_target_group.strapi_blue_tg.arn
  description = "ARN of the target group for the Strapi instances"
  
}

output "alb_dns_name" {
  value       = aws_lb.strapi_alb.dns_name
  description = "DNS name of the Application Load Balancer for Strapi"
  
}

output "blue_tg_name" {
  value       = aws_lb_target_group.strapi_blue_tg.name
  description = "Name of the blue target group for Strapi"
  
}

output "green_tg_name" {
  value       = aws_lb_target_group.strapi_green_tg.name
  description = "Name of the green target group for Strapi"
  
}


output "listener_arn" {
  value       = aws_lb_listener.strapi_http_listener.arn
  description = "ARN of the ALB listener for Strapi"
  
}


