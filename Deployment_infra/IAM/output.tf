output "iam-role" {
  value = aws_iam_role.iam-role.arn
}

output "ecs_cleanup_lambda_role" {
  value = aws_iam_role.ecs_cleanup_lambda_role.arn
}


output "codedeploy_role_arn" {
  value       = aws_iam_role.codedeploy_role.arn
  description = "IAM role for AWS CodeDeploy ECS deployments"
}


