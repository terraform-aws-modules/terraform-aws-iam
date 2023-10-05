data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

locals {
  account_id                         = data.aws_caller_identity.current.account_id
  partition                          = data.aws_partition.current.partition
  role_sts_externalid                = flatten([var.role_sts_externalid])
  role_name_condition                = var.role_name != null ? var.role_name : "${var.role_name_prefix}*"
  custom_role_trust_policy_condition = var.create_custom_role_trust_policy ? var.custom_role_trust_policy : ""
}

data "aws_iam_policy_document" "assume_role" {
  count = !var.create_custom_role_trust_policy && var.role_requires_mfa ? 0 : 1

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

  statement {
    effect  = "Allow"
    actions = compact(distinct(concat(["sts:AssumeRole"], var.trusted_role_actions)))

    principals {
      type        = "AWS"
      identifiers = var.trusted_role_arns
    }

    principals {
      type        = "Service"
      identifiers = var.trusted_role_services
    }

    dynamic "condition" {
      for_each = length(local.role_sts_externalid) != 0 ? [true] : []
      content {
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = local.role_sts_externalid
      }
    }

    dynamic "condition" {
      for_each = var.role_requires_session_name ? [1] : []
      content {
        test     = "StringEquals"
        variable = "sts:RoleSessionName"
        values   = var.role_session_name
      }
    }
  }
}

data "aws_iam_policy_document" "assume_role_with_mfa" {
  count = !var.create_custom_role_trust_policy && var.role_requires_mfa ? 1 : 0

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

  statement {
    effect  = "Allow"
    actions = compact(distinct(concat(["sts:AssumeRole"], var.trusted_role_actions)))

    principals {
      type        = "AWS"
      identifiers = var.trusted_role_arns
    }

    principals {
      type        = "Service"
      identifiers = var.trusted_role_services
    }

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }

    condition {
      test     = "NumericLessThan"
      variable = "aws:MultiFactorAuthAge"
      values   = [var.mfa_age]
    }

    dynamic "condition" {
      for_each = length(local.role_sts_externalid) != 0 ? [true] : []
      content {
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = local.role_sts_externalid
      }
    }

    dynamic "condition" {
      for_each = var.role_requires_session_name ? [1] : []
      content {
        test     = "StringEquals"
        variable = "sts:RoleSessionName"
        values   = var.role_session_name
      }
    }
  }
}

resource "aws_iam_role" "this" {
  count = var.create_role ? 1 : 0

  name                 = var.role_name
  name_prefix          = var.role_name_prefix
  path                 = var.role_path
  max_session_duration = var.max_session_duration
  description          = var.role_description

  force_detach_policies = var.force_detach_policies
  permissions_boundary  = var.role_permissions_boundary_arn

  assume_role_policy = coalesce(
    local.custom_role_trust_policy_condition,
    try(data.aws_iam_policy_document.assume_role_with_mfa[0].json,
      data.aws_iam_policy_document.assume_role[0].json
    )
  )

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "custom" {
  count = var.create_role ? coalesce(var.number_of_custom_role_policy_arns, length(var.custom_role_policy_arns)) : 0

  role       = aws_iam_role.this[0].name
  policy_arn = element(var.custom_role_policy_arns, count.index)
}

resource "aws_iam_role_policy_attachment" "admin" {
  count = var.create_role && var.attach_admin_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = var.admin_role_policy_arn
}

resource "aws_iam_role_policy_attachment" "poweruser" {
  count = var.create_role && var.attach_poweruser_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = var.poweruser_role_policy_arn
}

resource "aws_iam_role_policy_attachment" "readonly" {
  count = var.create_role && var.attach_readonly_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = var.readonly_role_policy_arn
}

resource "aws_iam_instance_profile" "this" {
  count = var.create_role && var.create_instance_profile ? 1 : 0
  name  = var.role_name
  path  = var.role_path
  role  = aws_iam_role.this[0].name

  tags = var.tags
}
