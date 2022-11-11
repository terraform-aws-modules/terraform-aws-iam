resource "aws_iam_policy" "notAction_policy" {
  name        = "notAction_policy"
  path        = "/"
  description = "Not Action policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        NotAction = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
