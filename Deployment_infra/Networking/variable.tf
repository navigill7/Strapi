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
   
}




