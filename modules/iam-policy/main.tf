resource "aws_iam_policy" "policy" {
  count = var.create_policy ? 1 : 0

  name        = var.name
  path        = var.path
  description = var.description

  policy = var.policy

  tags = var.tags
}
