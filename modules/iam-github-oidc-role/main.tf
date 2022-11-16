data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}

locals {
  github_token_url = "token.actions.githubusercontent.com"

  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition
  dns_suffix = data.aws_partition.current.dns_suffix
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
      identifiers = ["arn:${local.partition}:iam::${local.account_id}:oidc-provider/${local.github_token_url}"]
    }

    condition {
      test     = "ForAllValues:StringEquals"
      variable = "${local.github_token_url}:iss"
      values   = ["sts.${local.dns_suffix}"]
    }

    condition {
      test     = "ForAllValues:StringEquals"
      variable = "${local.github_token_url}:aud"
      values   = ["https://${local.github_token_url}"]
    }

    condition {
      test     = "StringLike"
      variable = "${local.github_token_url}:sub"
      values   = [for subject in var.subjects : "repo:${subject}"]
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
