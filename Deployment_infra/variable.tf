variable "cidr_block" {
  type = string
  description = "value for the CIDR block of the VPC"
}

variable "enable_dns_support" {
  type = bool
  default = true
  description = "Enable DNS support in the VPC"
}

variable "enable_dns_hostnames" {
  type = bool
  default = true
  description = "Enable DNS hostnames in the VPC"
  
}

variable "public_subnets" {
  type = list(string)
  description = "List of CIDR blocks for public subnets"    
  

  

}
variable "availability_zones" {
  type = list(string)
  description = "List of availability zones for the public subnets" 
  
}


variable "private_subnets" {
  type = list(string)
  description = "List of CIDR blocks for private subnets"
  default = []


}

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


variable "private_key_path" {
  description = "The path to the private key file for SSH access."
  type        = string
  
}


variable "notification_email" {
  description = "Email address to receive notifications from SNS"
  type        = string

  
}
