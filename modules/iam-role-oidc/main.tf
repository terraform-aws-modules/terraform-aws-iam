data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition

  oidc_providers     = [for url in var.oidc_provider_urls : replace(url, "https://", "")]
  github_provider    = coalesce(one(local.oidc_providers), "token.actions.githubusercontent.com")
  bitbucket_provider = one(local.oidc_providers)

  name_condition = var.name != null ? var.name : "${var.name_prefix}*"
}

################################################################################
# IAM Role
################################################################################

data "aws_iam_policy_document" "this" {
  count = var.create ? 1 : 0

  dynamic "statement" {
    # https://aws.amazon.com/blogs/security/announcing-an-update-to-iam-role-trust-policy-behavior/
    for_each = var.allow_self_assume_role ? [1] : []

    content {
      sid     = "ExplicitSelfRoleAssumption"
      effect  = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      condition {
        test     = "ArnLike"
        variable = "aws:PrincipalArn"
        values   = ["arn:${local.partition}:iam::${local.account_id}:role${var.path}${local.name_condition}"]
      }
    }
  }

  # Generic OIDC
  dynamic "statement" {
    for_each = !var.enable_github_oidc ? local.oidc_providers : []

    content {
      effect  = "Allow"
      actions = ["sts:AssumeRoleWithWebIdentity"]

      principals {
        type = "Federated"

        identifiers = ["arn:${local.partition}:iam::${coalesce(var.oidc_account_id, local.account_id)}:oidc-provider/${statement.value}"]
      }

      dynamic "condition" {
        for_each = length(var.oidc_subjects) > 0 ? local.oidc_providers : []

        content {
          test     = "StringEquals"
          variable = "${statement.value}:sub"
          values   = var.oidc_subjects
        }
      }

      dynamic "condition" {
        for_each = length(var.oidc_wildcard_subjects) > 0 ? local.oidc_providers : []

        content {
          test     = "StringLike"
          variable = "${statement.value}:sub"
          values   = var.oidc_wildcard_subjects
        }
      }

      dynamic "condition" {
        for_each = length(var.oidc_audiences) > 0 ? local.oidc_providers : []

        content {
          test     = "StringLike"
          variable = "${statement.value}:aud"
          values   = var.oidc_audiences
        }
      }
    }
  }

  # GitHub OIDC
  dynamic "statement" {
    for_each = var.enable_github_oidc ? [1] : []

    content {
      sid = "GithubOidcAuth"
      actions = [
        "sts:TagSession",
        "sts:AssumeRoleWithWebIdentity"
      ]

      principals {
        type        = "Federated"
        identifiers = ["arn:${local.partition}:iam::${local.account_id}:oidc-provider/${local.github_provider}"]
      }

      condition {
        test     = "ForAllValues:StringEquals"
        variable = "token.actions.githubusercontent.com:iss"
        values   = ["http://token.actions.githubusercontent.com"]
      }

      condition {
        test     = "ForAllValues:StringEquals"
        variable = "${local.github_provider}:aud"
        values   = coalescelist(var.oidc_audiences, ["sts.amazonaws.com"])
      }

      condition {
        test     = "StringLike"
        variable = "${local.github_provider}:sub"
        # Strip `repo:` to normalize for cases where users may prepend it
        values = [for subject in var.oidc_subjects : "repo:${trimprefix(subject, "repo:")}"]
      }
    }
  }

  # Bitbucket OIDC
  dynamic "statement" {
    for_each = var.enable_bitbucket_oidc ? [1] : []

    content {
      sid = "BitbucketOidcAuth"
      actions = [
        "sts:TagSession",
        "sts:AssumeRoleWithWebIdentity"
      ]

      principals {
        type        = "Federated"
        identifiers = ["arn:${local.partition}:iam::${local.account_id}:oidc-provider/${local.bitbucket_provider}"]
      }

      condition {
        test     = "ForAllValues:StringEquals"
        variable = "${local.bitbucket_provider}:aud"
        values   = coalescelist(var.oidc_audiences, ["sts.amazonaws.com"])
      }

      condition {
        test     = "StringLike"
        variable = "${local.bitbucket_provider}:sub"
        values   = var.oidc_subjects
      }
    }
  }

  # Generic statements
  dynamic "statement" {
    for_each = var.assume_role_policy_statements

    content {
      sid           = try(statement.value.sid, null)
      actions       = try(statement.value.actions, ["sts:AssumeRole"])
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

resource "aws_iam_role" "this" {
  count = var.create ? 1 : 0

  name        = var.name
  name_prefix = var.name_prefix
  path        = var.path
  description = var.description

  assume_role_policy    = data.aws_iam_policy_document.this[0].json
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.permissions_boundary
  force_detach_policies = true

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = { for k, v in var.policies : k => v if var.create }

  policy_arn = each.value
  role       = aws_iam_role.this[0].name
}
