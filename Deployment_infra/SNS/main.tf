resource "aws_sns_topic" "ecs_alarm_topic" {
  name = "strapi-ecs-alarm-topic"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.ecs_alarm_topic.arn
  protocol  = "email"
  endpoint  = var.notification_email  
}
