################################################################################
# IAM Policy
################################################################################

resource "aws_iam_policy" "policy" {
  count = var.create ? 1 : 0

  description = var.description
  name        = var.name
  name_prefix = var.name_prefix
  path        = var.path
  policy      = var.policy

  tags = var.tags
}
