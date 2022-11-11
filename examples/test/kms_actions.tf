resource "aws_iam_policy" "policy" {
  name        = "kms_action"
  description = "My policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Effect = "Allow",
            Action = "*",
            Resource = "kms:Decrypt",
            Condition = {
                BoolIfExists = {
                    aws = MultiFactorAuthPresent = "false"
                }
            }
        }
    ]
  })
}

resource "aws_iam_policy" "policy" {
  name        = "kms_action*"
  description = "My policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
        {
            Effect = "Allow",
            Action = "*",
            Resource = "*",
            Condition = {
                BoolIfExists = {
                    aws = MultiFactorAuthPresent = "false"
                }
            }
        }
    ]
  })
}
