data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

locals {
  account_id          = data.aws_caller_identity.current.account_id
  partition           = data.aws_partition.current.partition
  role_name_condition = var.role_name != null ? var.role_name : "${var.role_name_prefix}*"
}

data "aws_eks_cluster" "main" {
  for_each = { for k, v in var.cluster_service_accounts : k => v if var.create_role }

  name = each.key
}

data "aws_iam_policy_document" "assume_role_with_oidc" {
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
        values   = ["arn:${local.partition}:iam::${local.account_id}:role${var.role_path}${local.role_name_condition}"]
      }
    }
  }

  dynamic "statement" {
    for_each = { for k, v in var.cluster_service_accounts : k => v if var.create_role }

    content {
      effect  = "Allow"
      actions = ["sts:AssumeRoleWithWebIdentity"]

      principals {
        type = "Federated"

        identifiers = [
          "arn:${local.partition}:iam::${local.account_id}:oidc-provider/${replace(data.aws_eks_cluster.main[statement.key].identity[0].oidc[0].issuer, "https://", "")}"
        ]
      }

      condition {
        test     = var.assume_role_condition_test
        variable = "${replace(data.aws_eks_cluster.main[statement.key].identity[0].oidc[0].issuer, "https://", "")}:sub"
        values   = [for s in statement.value : "system:serviceaccount:${s}"]
      }
    }
  }
}

resource "aws_iam_role" "this" {
  count = var.create_role ? 1 : 0

  assume_role_policy    = data.aws_iam_policy_document.assume_role_with_oidc.json
  description           = var.role_description
  force_detach_policies = var.force_detach_policies
  max_session_duration  = var.max_session_duration
  name                  = var.role_name
  name_prefix           = var.role_name_prefix
  path                  = var.role_path
  permissions_boundary  = var.role_permissions_boundary_arn
  tags                  = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = { for k, v in var.role_policy_arns : k => v if var.create_role }

  role       = aws_iam_role.this[0].name
  policy_arn = each.value
}

###############################
# IAM Role Inline policy
###############################

locals {
  create_iam_role_inline_policy = var.create_role && length(var.inline_policy_statements) > 0
}

data "aws_iam_policy_document" "inline" {
  count = local.create_iam_role_inline_policy ? 1 : 0

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
  count = local.create_iam_role_inline_policy ? 1 : 0

  role        = aws_iam_role.this[0].name
  name_prefix = "${var.role_name}_inline_"
  policy      = data.aws_iam_policy_document.inline[0].json
}
