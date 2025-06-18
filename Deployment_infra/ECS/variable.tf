variable "execution_role_arn" {
type = string
}
  
variable "target_group_arn" {
type = string
}
  
  variable "vpc_id" {
  description = "VPC ID for the ALB"
  type        = string
}

variable "subnet_ids" {
  description = "List of Subnet IDs for the ALB"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group ID for the ALB"
  type        = set(string)
}


