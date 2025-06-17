variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance."
  type        = string
  
}

variable "instance_type" {
  description = "The type of instance to use for the EC2 instance."
  type        = string
  default     = "t2.medium"
  
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access to the EC2 instance."
  type        = string      
  
}

variable "vpc_id" {
  description = "The ID of the VPC where the EC2 instance will be launched."
  type        = string
  
}

variable "subnet_id" {
  description = "The ID of the subnet where the EC2 instance will be launched."
  type        = list(string)
  
}

variable "strapi_security_group_id" {
  description = "The ID of the security group for the Strapi instance."
  type        = string
  
}

variable "bastion_security_group_id" {
  description = "The ID of the security group for the bastion host."
  type        = string
  
}


variable "public_subnet_ids" {
  description = "The ID of the public subnet where the bastion host will be launched."
  type        = list(string)
  
}

variable "private_key_path" {
  description = "The path to the private key file for SSH access."
  type        = string
  
}

