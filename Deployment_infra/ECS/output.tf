output "cluster_name" {
  value       = aws_ecs_cluster.strapi_cluster.name
  description = "Name of the ECS cluster for Strapi"
  
}

output "service_name" {
  value       = aws_ecs_service.strapi_service.name
  description = "Name of the ECS service for Strapi"
  
}

output "task_definition_arn" {
  value       = aws_ecs_task_definition.strapi_task_definition.arn
  description = "ARN of the ECS task definition for Strapi"
  
}

