data "aws_iam_policy_document" "assume_role" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = var.assumable_roles
  }
}

resource "aws_iam_policy" "this" {
  name        = var.name
  description = "Allows to assume role in another AWS account"
  policy      = data.aws_iam_policy_document.assume_role.json

  tags = var.tags
}

resource "aws_iam_group" "this" {
  name = var.name
}

resource "aws_iam_group_policy_attachment" "this" {
  group      = aws_iam_group.this.id
  policy_arn = aws_iam_policy.this.id
}

resource "aws_iam_group_membership" "this" {
  count = length(var.group_users) > 0 ? 1 : 0

  group = aws_iam_group.this.id
  name  = var.name
  users = var.group_users
}
