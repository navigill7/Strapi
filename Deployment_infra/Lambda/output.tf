output "aws_lambda_arn" {
  value       = aws_lambda_function.ecs_cleanup.arn
  description = "ARN of the ECS cleanup Lambda function"
  
}


output "lambda_name" {
  value = aws_lambda_function.ecs_cleanup.function_name
}


