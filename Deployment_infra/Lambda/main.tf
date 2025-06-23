resource "aws_lambda_function" "ecs_cleanup" {
  function_name = "ecs-cleanup"
  s3_bucket     = "lambda-script-strapi-cleanup"
  s3_key        = "ecs_cleanup.zip"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"
  role          = var.lambda_role
  timeout       = 60
  memory_size   = 512

  vpc_config {
    subnet_ids         = var.private_subnet_ids
    security_group_ids = [var.lambda_security_group_id]
  }

  environment {
    variables = {
      ENV = "prod"
    }
  }
}
