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

# module "compute" {
#   source = "./compute"
#   vpc_id = module.networking.aws_vpc_id
#   ami_id = var.ami_id
#    public_subnet_ids = module.networking.aws_public_subnet_ids
#   subnet_id = module.networking.aws_private_subnet_ids
#   strapi_security_group_id = module.security.aws_security_group_strapi_id
#   bastion_security_group_id = module.security.aws_bastion_security_group_id
#   instance_type = var.instance_type
#   key_name = var.key_name
#   private_key_path = var.private_key_path
# }


module "iam" {
  source = "./IAM"
  
}
module "ecs" {
  source = "./ECS"
  vpc_id = module.networking.aws_vpc_id
  execution_role_arn = module.iam.iam-role
  target_group_arn = module.alb.target_group_arn
  subnet_ids = module.networking.aws_private_subnet_ids
  security_group_id = toset([module.security.aws_alb_security_group_id])
}

module "alb" {
  source = "./ALB"
  vpc_id = module.networking.aws_vpc_id
  public_subnet_ids = module.networking.aws_public_subnet_ids
  alb_security_group_id = module.security.aws_alb_security_group_id


}

module "sns" {
  source = "./SNS"
  notification_email = var.notification_email
}


module "cloudwatch" {
  source = "./cloudwatch"
  ecs_alarm_topic_arn = module.sns.sns_topic_arn
  ecs_cleanup_lambda_arn = module.lambda.aws_lambda_arn
  lambda_name = module.lambda.lambda_name
  
}


module "lambda" {
  source = "./Lambda"
  private_subnet_ids = module.networking.aws_private_subnet_ids
  lambda_security_group_id = module.security.lambda_sg
  lambda_role = module.iam.ecs_cleanup_lambda_role
}


module "codedeploy" {
  source = "./CodeDeploy"
  codedeploy_role_arn = module.iam.codedeploy_role_arn
  cluster_name = module.ecs.cluster_name
  service_name = module.ecs.service_name
  listener_arns = module.alb.listener_arn
  blue_tg_name = module.alb.blue_tg_name
  green_tg_name = module.alb.green_tg_name
}


output "dns" {
  value = module.alb.alb_dns_name
  description = "The DNS name of the ALB for Strapi."
}


output "latest_task_definition_arn" {
  value = module.ecs.task_definition_arn
  description = "The latest ECS task definition ARN"
}


