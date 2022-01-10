locals {
  group_name = element(concat(aws_iam_group.this.*.id, [var.name]), 0)
}

resource "aws_iam_group" "this" {
  count = var.create_group ? 1 : 0

  name = var.name
}

resource "aws_iam_group_membership" "this" {
  count = length(var.group_users) > 0 ? 1 : 0

  group = local.group_name
  name  = var.name
  users = var.group_users
}

################################
# IAM group policy attachements
################################
resource "aws_iam_group_policy_attachment" "iam_self_management" {
  count = var.attach_iam_self_management_policy ? 1 : 0

  group      = local.group_name
  policy_arn = aws_iam_policy.iam_self_management[0].arn
}

resource "aws_iam_group_policy_attachment" "custom_arns" {
  count = length(var.custom_group_policy_arns)

  group      = local.group_name
  policy_arn = element(var.custom_group_policy_arns, count.index)
}

resource "aws_iam_group_policy_attachment" "custom" {
  count = length(var.custom_group_policies)

  group      = local.group_name
  policy_arn = element(aws_iam_policy.custom.*.arn, count.index)
}

###############
# IAM policies
###############
resource "aws_iam_policy" "iam_self_management" {
  count = var.attach_iam_self_management_policy ? 1 : 0

  name_prefix = var.iam_self_management_policy_name_prefix
  policy      = data.aws_iam_policy_document.iam_self_management.json

  tags = var.tags
}

resource "aws_iam_policy" "custom" {
  count = length(var.custom_group_policies)

  name        = var.custom_group_policies[count.index]["name"]
  policy      = var.custom_group_policies[count.index]["policy"]
  description = lookup(var.custom_group_policies[count.index], "description", null)

  tags = var.tags
}
