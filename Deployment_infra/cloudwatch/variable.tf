variable "ecs_alarm_topic_arn" {
  description = "ARN of the SNS topic for ECS alarms"
  type        = string
  
}


variable "ecs_cleanup_lambda_arn" {
  description = "ARN of the ECS cleanup Lambda function"
  type        = string
  
}


variable "lambda_name" {
  description = "Name of the ECS cleanup Lambda function"
  type        = string
  
}