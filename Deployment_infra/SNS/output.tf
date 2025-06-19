output "sns_topic_arn" {
  description = "The ARN of the SNS topic created for Strapi deployment notifications."
  value       = aws_sns_topic.ecs_alarm_topic.arn
  
}