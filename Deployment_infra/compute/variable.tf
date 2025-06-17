output "aws_strapi_instance_ids" {
  value       = aws_instance.strapi_instance[*].id
  description = "List of IDs of the Strapi instances"
  
}

output "bastion_instance_id" {
  value       = aws_instance.strapi_bastion_host.id
  description = "ID of the bastion host instance"
  
}

