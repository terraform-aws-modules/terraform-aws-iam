locals {
  aws_account_id = var.aws_account_id != "" ? var.aws_account_id : data.aws_caller_identity.current.account_id
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "assume_role_with_oidc" {
  count = var.create_role ? 1 : 0

  statement {
    effect = "Allow"

    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type = "Federated"

      identifiers = [
        "arn:aws:iam::${local.aws_account_id}:oidc-provider/${var.provider_url}"
      ]
    }

    dynamic "condition" {
      for_each = var.oidc_fully_qualified_subjects
      content {
        test     = "StringEquals"
        variable = "${var.provider_url}:sub"
        values   = [condition.value]
      }
    }

    dynamic "condition" {
      for_each = var.oidc_subjects_with_wildcards
      content {
        test     = "StringLike"
        variable = "${var.provider_url}:sub"
        values   = [condition.value]
      }
    }
  }
}

resource "aws_iam_role" "this" {
  count = var.create_role ? 1 : 0

  name                 = var.role_name
  path                 = var.role_path
  max_session_duration = var.max_session_duration

  permissions_boundary = var.role_permissions_boundary_arn

  assume_role_policy = join("", data.aws_iam_policy_document.assume_role_with_oidc.*.json)

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "custom" {
  count = var.create_role && length(var.role_policy_arns) > 0 ? length(var.role_policy_arns) : 0

  role       = join("", aws_iam_role.this.*.name)
  policy_arn = var.role_policy_arns[count.index]
}
