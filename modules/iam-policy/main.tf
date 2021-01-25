resource "aws_iam_policy" "policy" {
  count = var.create ? 1 : 0

  name        = var.name
  path        = var.path
  description = var.description

  policy = var.policy
}

