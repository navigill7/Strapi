resource "aws_cloudwatch_metric_alarm" "ecs_cpu_high" {
  alarm_name          = "ECS-High-CPU-Utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 70
  alarm_description   = "This alarm triggers when ECS service CPU usage exceeds 70%."
  dimensions = {
    ClusterName = "strapi-deployment-cluster"
    ServiceName = "cluster-service" 
  }
  alarm_actions = [var.ecs_alarm_topic_arn]
}



resource "aws_cloudwatch_metric_alarm" "ecs_memory_high" {
  alarm_name          = "ECS-High-Memory-Utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This alarm triggers when ECS service memory usage exceeds 80%."
  dimensions = {
    ClusterName = "strapi-deployment-cluster"
    ServiceName = "cluster-service"
  }
  alarm_actions = [var.ecs_alarm_topic_arn]
}
