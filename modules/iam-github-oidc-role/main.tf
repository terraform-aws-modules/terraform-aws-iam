data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}

locals {
  # Just extra safety incase someone passes in a url with `https://`
  provider_url = replace(var.provider_url, "https://", "")

  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition
}

################################################################################
# GitHub OIDC Role
################################################################################

data "aws_iam_policy_document" "this" {
  count = var.create ? 1 : 0

  statement {
    sid    = "GithubOidcAuth"
    effect = "Allow"
    actions = [
      "sts:TagSession",
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type        = "Federated"
      identifiers = ["arn:${local.partition}:iam::${local.account_id}:oidc-provider/${local.provider_url}"]
    }

    condition {
      test     = "ForAllValues:StringEquals"
      variable = "token.actions.githubusercontent.com:iss"
      values   = ["https://token.actions.githubusercontent.com"]
    }

    condition {
      test     = "ForAllValues:StringEquals"
      variable = "${local.provider_url}:aud"
      values   = [var.audience]
    }

    condition {
      test     = "StringLike"
      variable = "${local.provider_url}:sub"
      # Strip `repo:` to normalize for cases where users may prepend it
      values = [for subject in var.subjects : "repo:${trimprefix(subject, "repo:")}"]
    }
  }
}

resource "aws_iam_role" "this" {
  count = var.create ? 1 : 0

  name        = var.name
  name_prefix = var.name_prefix
  path        = var.path
  description = var.description

  assume_role_policy    = data.aws_iam_policy_document.this[0].json
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.permissions_boundary_arn
  force_detach_policies = var.force_detach_policies

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = { for k, v in var.policies : k => v if var.create }

  role       = aws_iam_role.this[0].name
  policy_arn = each.value
}

################################################################################
# IAM Role Inline policy
################################################################################

data "aws_iam_policy_document" "inline" {
  count = var.create && length(var.inline_policy_statements) > 0 ? 1 : 0

  dynamic "statement" {
    for_each = var.inline_policy_statements

    content {
      sid           = try(statement.value.sid, null)
      actions       = try(statement.value.actions, null)
      not_actions   = try(statement.value.not_actions, null)
      effect        = try(statement.value.effect, null)
      resources     = try(statement.value.resources, null)
      not_resources = try(statement.value.not_resources, null)

      dynamic "principals" {
        for_each = try(statement.value.principals, [])

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = try(statement.value.not_principals, [])

        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = try(statement.value.conditions, [])

        content {
          test     = condition.value.test
          values   = condition.value.values
          variable = condition.value.variable
        }
      }
    }
  }
}

resource "aws_iam_role_policy" "inline" {
  count = var.create && (length(var.inline_policy_statements) > 0 || var.inline_policy_json_document != null) ? 1 : 0

  role        = aws_iam_role.this[0].name
  name_prefix = "${var.name}_inline_"
  policy      = var.inline_policy_json_document != null ? var.inline_policy_json_document : data.aws_iam_policy_document.inline[0].json
}
