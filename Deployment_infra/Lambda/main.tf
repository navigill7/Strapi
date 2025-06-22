resource "aws_lambda_function" "ecs_cleanup" {
  function_name = "ecs-cleanup"

  filename         = "ecs_cleanup.zip"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  role             = var.lambda_role
  timeout          = 60
  memory_size      = 512
  source_code_hash = filebase64sha256("ecs_cleanup.zip")


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
