provider "aws" {
  region = "us-east-1"
}

module "networking" {
  source = "./Networking"
  cidr_block = var.cidr_block
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  public_subnets = var.public_subnets
  availability_zones = var.availability_zones
  private_subnets = var.private_subnets
  
}


module "security" {
  source = "./security"
  vpc_id = module.networking.aws_vpc_id
}

module "compute" {
  source = "./compute"
  vpc_id = module.networking.aws_vpc_id
  ami_id = var.ami_id
   public_subnet_ids = module.networking.aws_public_subnet_ids
  subnet_id = module.networking.aws_private_subnet_ids
  strapi_security_group_id = module.security.aws_security_group_strapi_id
  bastion_security_group_id = module.security.aws_bastion_security_group_id
  instance_type = var.instance_type
  key_name = var.key_name
  private_key_path = var.private_key_path
}

module "alb" {
  source = "./ALB"
  vpc_id = module.networking.aws_vpc_id
  public_subnet_ids = module.networking.aws_public_subnet_ids
  alb_security_group_id = module.security.aws_alb_security_group_id
  strapi_instance_ids = module.compute.aws_strapi_instance_ids


}





output "dns" {
  value = module.alb.alb_dns_name
  description = "The DNS name of the ALB for Strapi."
}

