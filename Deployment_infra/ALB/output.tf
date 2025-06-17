output "target_group_arn" {
  value       = aws_lb_target_group.strapi_target_group.arn
  description = "ARN of the target group for the Strapi instances"
  
}

output "alb_dns_name" {
  value       = aws_lb.strapi_alb.dns_name
  description = "DNS name of the Application Load Balancer for Strapi"
  
}

