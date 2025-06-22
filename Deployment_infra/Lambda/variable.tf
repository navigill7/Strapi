variable "private_subnet_ids" {
  description = "List of private subnet IDs for the Lambda function"
  type        = list(string)
  
}


variable "lambda_security_group_id" {
  description = "Security group ID for the Lambda function"
  type        = string
  
}


variable "lambda_role" {
  description = "IAM role ARN for the Lambda function"
  type        = string
}