locals {
  group_name = var.create_group ? aws_iam_group.this[0].id : var.name
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = var.assumable_roles
  }
}

resource "aws_iam_policy" "this" {
  name        = "${local.group_name}${var.assumable_roles_policy_name_suffix}"
  path        = var.path
  description = "Allows to assume role in another AWS account"
  policy      = data.aws_iam_policy_document.assume_role.json

  tags = var.tags
}

resource "aws_iam_group" "this" {
  count = var.create_group ? 1 : 0

  name = var.name
  path = var.path
}

resource "aws_iam_group_policy_attachment" "this" {
  group      = local.group_name
  policy_arn = aws_iam_policy.this.id
}

resource "aws_iam_group_membership" "this" {
  count = length(var.group_users) > 0 ? 1 : 0

  group = local.group_name
  name  = local.group_name
  users = var.group_users
}
