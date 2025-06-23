resource "aws_iam_role" "iam-role" {
  name = "strapi_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    tag-key = "medusa-role"
  }
}

resource "aws_iam_policy" "iam-policy" {
  name        = "test-policy"
  description = "A test policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecs:*", 
          "logs:*",
          "ec2:*"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "role-attach" {
  role       = aws_iam_role.iam-role.name
  policy_arn = aws_iam_policy.iam-policy.arn
}

resource "aws_iam_role" "ecs_cleanup_lambda_role" {
  name = "ecs-cleanup-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "ecs_cleanup_policy" {
  name        = "ecs-cleanup-permissions"
  description = "Allows ECS and EC2 ENI cleanup"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ecs:ListClusters",
          "ecs:ListServices",
          "ecs:ListTasks",
          "ecs:DescribeServices",
          "ecs:DescribeTasks",
          "ecs:StopTask",
          "ecs:DeleteService"
        ],
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface",
          "ec2:CreateNetworkInterface"         # ✅ Added this line
        ],
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_cleanup_attach" {
  role       = aws_iam_role.ecs_cleanup_lambda_role.name
  policy_arn = aws_iam_policy.ecs_cleanup_policy.arn
}
