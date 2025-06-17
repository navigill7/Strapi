output "aws_vpc_id" {
  value = aws_vpc.strapi_vpc.id
  description = "ID of the VPC for Strapi deployment"
  
}

output "aws_public_subnet_ids" {
  value = aws_subnet.strapi_public_subnet[*].id
  description = "List of public subnet IDs"
  
}

output "aws_private_subnet_ids" {
  value = aws_subnet.strapi_private_subnet[*].id
  description = "List of private subnet IDs"
  

}


output "aws_route_table_id" {
  value = aws_route_table.strapi_route_table.id
  description = "ID of the route table for public subnets"
  
}



