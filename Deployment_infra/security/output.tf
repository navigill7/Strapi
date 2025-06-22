output "aws_bastion_security_group_id" {
  value = aws_security_group.strapi_security_group_bastion_host.id
  description = "ID of the security group for the bastion host"
  
}


output "aws_alb_security_group_id" {
  value = aws_security_group.ALB_Security_Group.id
  description = "ID of the security group for the Application Load Balancer"
  
}


output "aws_security_group_strapi_id" {
  value = aws_security_group.strapi_security_group.id
  description = "ID of the security group for the Strapi instance"
  
}

output "lambda_sg" {
  value = aws_security_group.lambda_sg.id
  description = "Security group ID for the Lambda function"
}




