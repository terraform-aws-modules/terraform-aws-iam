data "aws_caller_identity" "current" {
  count = var.create ? 1 : 0
}
data "aws_partition" "current" {
  count = var.create ? 1 : 0
}

locals {
  account_id = try(data.aws_caller_identity.current[0].account_id, "")
  partition  = try(data.aws_partition.current[0].partition, "")

  oidc_providers     = [for url in var.oidc_provider_urls : replace(url, "https://", "")]
  bitbucket_provider = try(element(local.oidc_providers, 0), null)
}

################################################################################
# IAM Role
################################################################################

data "aws_iam_policy_document" "this" {
  count = var.create ? 1 : 0

  # Generic OIDC
  dynamic "statement" {
    for_each = var.enable_oidc ? local.oidc_providers : []

    content {
      effect = "Allow"
      actions = [
        "sts:TagSession",
        "sts:AssumeRoleWithWebIdentity",
      ]

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
          test     = "StringEquals"
          variable = "${statement.value}:aud"
          values   = var.oidc_audiences
        }
      }

      # Generic conditions
      dynamic "condition" {
        for_each = var.trust_policy_conditions

        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
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
        "sts:AssumeRoleWithWebIdentity",
      ]

      principals {
        type        = "Federated"
        identifiers = ["arn:${local.partition}:iam::${local.account_id}:oidc-provider/${var.github_provider}"]
      }

      condition {
        test     = "ForAllValues:StringEquals"
        variable = "${var.github_provider}:iss"
        values   = ["https://${var.github_provider}"]
      }

      condition {
        test     = "ForAllValues:StringEquals"
        variable = "${var.github_provider}:aud"
        values   = coalescelist(var.oidc_audiences, ["sts.amazonaws.com"])
      }

      dynamic "condition" {
        for_each = length(var.oidc_subjects) > 0 ? [1] : []

        content {
          test     = "StringEquals"
          variable = "${var.github_provider}:sub"
          # Strip `repo:` to normalize for cases where users may prepend it
          values = [for subject in var.oidc_subjects : "repo:${trimprefix(subject, "repo:")}"]
        }
      }

      dynamic "condition" {
        for_each = length(var.oidc_wildcard_subjects) > 0 ? [1] : []

        content {
          test     = "StringLike"
          variable = "${var.github_provider}:sub"
          # Strip `repo:` to normalize for cases where users may prepend it
          values = [for subject in var.oidc_wildcard_subjects : "repo:${trimprefix(subject, "repo:")}"]
        }
      }

      # Generic conditions
      dynamic "condition" {
        for_each = var.trust_policy_conditions

        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
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
        "sts:AssumeRoleWithWebIdentity",
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

      dynamic "condition" {
        for_each = length(var.oidc_subjects) > 0 ? [1] : []

        content {
          test     = "StringEquals"
          variable = "${local.bitbucket_provider}:sub"
          values   = var.oidc_subjects
        }
      }

      dynamic "condition" {
        for_each = length(var.oidc_wildcard_subjects) > 0 ? [1] : []

        content {
          test     = "StringLike"
          variable = "${local.bitbucket_provider}:sub"
          values   = var.oidc_wildcard_subjects
        }
      }

      # Generic conditions
      dynamic "condition" {
        for_each = var.trust_policy_conditions

        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }

  # SAML
  dynamic "statement" {
    for_each = var.enable_saml ? [1] : []

    content {
      effect = "Allow"
      actions = compact(distinct(concat(
        [
          "sts:TagSession",
          "sts:AssumeRoleWithSAML",
        ],
      var.saml_trust_actions)))

      principals {
        type        = "Federated"
        identifiers = var.saml_provider_ids
      }

      condition {
        test     = "StringEquals"
        variable = "SAML:aud"
        values   = var.saml_endpoints
      }

      # Generic conditions
      dynamic "condition" {
        for_each = var.trust_policy_conditions

        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }

  # Generic statements
  dynamic "statement" {
    for_each = var.trust_policy_permissions != null ? var.trust_policy_permissions : {}

    content {
      sid           = try(coalesce(statement.value.sid, statement.key))
      actions       = statement.value.actions
      not_actions   = statement.value.not_actions
      effect        = statement.value.effect
      resources     = statement.value.resources
      not_resources = statement.value.not_resources

      dynamic "principals" {
        for_each = statement.value.principals != null ? statement.value.principals : []

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = statement.value.not_principals != null ? statement.value.not_principals : []

        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = statement.value.condition != null ? statement.value.condition : []

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

  name        = var.use_name_prefix ? null : var.name
  name_prefix = var.use_name_prefix ? "${var.name}-" : null
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

################################################################################
# IAM Role Inline policy
################################################################################

locals {
  create_inline_policy = var.create && var.create_inline_policy
}

data "aws_iam_policy_document" "inline" {
  count = local.create_inline_policy ? 1 : 0

  source_policy_documents   = var.source_inline_policy_documents
  override_policy_documents = var.override_inline_policy_documents

  dynamic "statement" {
    for_each = var.inline_policy_permissions != null ? var.inline_policy_permissions : {}

    content {
      sid           = try(coalesce(statement.value.sid, statement.key))
      actions       = statement.value.actions
      not_actions   = statement.value.not_actions
      effect        = statement.value.effect
      resources     = statement.value.resources
      not_resources = statement.value.not_resources

      dynamic "principals" {
        for_each = statement.value.principals != null ? statement.value.principals : []

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = statement.value.not_principals != null ? statement.value.not_principals : []

        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = statement.value.condition != null ? statement.value.condition : []

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
  count = local.create_inline_policy ? 1 : 0

  role        = aws_iam_role.this[0].name
  name        = var.use_name_prefix ? null : var.name
  name_prefix = var.use_name_prefix ? "${var.name}-" : null
  policy      = data.aws_iam_policy_document.inline[0].json
}

################################################################################
# IAM Instance Profile
################################################################################

resource "aws_iam_instance_profile" "this" {
  count = var.create && var.create_instance_profile ? 1 : 0

  role = aws_iam_role.this[0].name

  name        = var.use_name_prefix ? null : var.name
  name_prefix = var.use_name_prefix ? "${var.name}-" : null
  path        = var.path

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}
