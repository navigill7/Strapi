variable "public_subnet_ids" {
  description = "List of public subnet IDs for the load balancer."
  type        = list(string)
  

}
variable "alb_security_group_id" {
  description = "The security group for the Application Load Balancer."
  type        = string
  
}

variable "vpc_id" {
  description = "The ID of the VPC where the load balancer will be deployed."
  type        = string
  
}