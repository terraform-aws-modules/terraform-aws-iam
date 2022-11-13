resource "aws_iam_policy" "policy" {
  name        = "test_policy"
  path        = "/"
  description = "Policy wildcard-1"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
