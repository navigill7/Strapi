variable "codedeploy_role_arn" {
  type = string
  description = "ARN of the IAM role for CodeDeploy"
}

variable "cluster_name" {
  type = string
  description = "Name of the ECS cluster where the Strapi service is deployed"
  
}

variable "service_name" {
  type = string
  description = "Name of the ECS service for Strapi"    
  
}


variable "listener_arns" {
  type = string
  description = "ARN of the ALB listener for the Strapi service"    
  
}

variable "blue_tg_name" {
  type = string
  description = "Name of the blue target group for Strapi"      


  
}

variable "green_tg_name" {
  type = string
  description = "Name of the green target group for Strapi"
  
}