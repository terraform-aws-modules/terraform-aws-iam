data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition
}

data "aws_iam_policy_document" "assume_role" {
  dynamic "statement" {
    # https://aws.amazon.com/blogs/security/announcing-an-update-to-iam-role-trust-policy-behavior/
    for_each = var.allow_self_assume_role && var.create_admin_role ? [1] : []

    content {
      sid     = "ExplicitSelfAdminRoleAssumption"
      effect  = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      condition {
        test     = "ArnLike"
        variable = "aws:PrincipalArn"
        values   = ["arn:${local.partition}:iam::${local.account_id}:role${var.admin_role_path}${var.admin_role_name}"]
      }
    }
  }

  dynamic "statement" {
    # https://aws.amazon.com/blogs/security/announcing-an-update-to-iam-role-trust-policy-behavior/
    for_each = var.allow_self_assume_role && var.create_poweruser_role ? [1] : []

    content {
      sid     = "ExplicitSelfPowerUserRoleAssumption"
      effect  = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      condition {
        test     = "ArnLike"
        variable = "aws:PrincipalArn"
        values   = ["arn:${local.partition}:iam::${local.account_id}:role${var.poweruser_role_path}${var.poweruser_role_name}"]
      }
    }
  }

  dynamic "statement" {
    # https://aws.amazon.com/blogs/security/announcing-an-update-to-iam-role-trust-policy-behavior/
    for_each = var.allow_self_assume_role && var.create_readonly_role ? [1] : []

    content {
      sid     = "ExplicitSelfReadOnlyRoleAssumption"
      effect  = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      condition {
        test     = "ArnLike"
        variable = "aws:PrincipalArn"
        values   = ["arn:${local.partition}:iam::${local.account_id}:role${var.readonly_role_path}${var.readonly_role_name}"]
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
  }
}

data "aws_iam_policy_document" "assume_role_with_mfa" {
  dynamic "statement" {
    # https://aws.amazon.com/blogs/security/announcing-an-update-to-iam-role-trust-policy-behavior/
    for_each = var.allow_self_assume_role && var.create_admin_role ? [1] : []

    content {
      sid     = "ExplicitSelfAdminRoleAssumption"
      effect  = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      condition {
        test     = "ArnLike"
        variable = "aws:PrincipalArn"
        values   = ["arn:${local.partition}:iam::${local.account_id}:role${var.admin_role_path}${var.admin_role_name}"]
      }
    }
  }

  dynamic "statement" {
    # https://aws.amazon.com/blogs/security/announcing-an-update-to-iam-role-trust-policy-behavior/
    for_each = var.allow_self_assume_role && var.create_poweruser_role ? [1] : []

    content {
      sid     = "ExplicitSelfPowerUserRoleAssumption"
      effect  = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      condition {
        test     = "ArnLike"
        variable = "aws:PrincipalArn"
        values   = ["arn:${local.partition}:iam::${local.account_id}:role${var.poweruser_role_path}${var.poweruser_role_name}"]
      }
    }
  }

  dynamic "statement" {
    # https://aws.amazon.com/blogs/security/announcing-an-update-to-iam-role-trust-policy-behavior/
    for_each = var.allow_self_assume_role && var.create_readonly_role ? [1] : []

    content {
      sid     = "ExplicitSelfReadOnlyRoleAssumption"
      effect  = "Allow"
      actions = ["sts:AssumeRole"]

      principals {
        type        = "AWS"
        identifiers = ["*"]
      }

      condition {
        test     = "ArnLike"
        variable = "aws:PrincipalArn"
        values   = ["arn:${local.partition}:iam::${local.account_id}:role${var.readonly_role_path}${var.readonly_role_name}"]
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
  }
}

# Admin
resource "aws_iam_role" "admin" {
  count = var.create_admin_role ? 1 : 0

  name                 = var.admin_role_name
  path                 = var.admin_role_path
  max_session_duration = var.max_session_duration

  force_detach_policies = var.force_detach_policies
  permissions_boundary  = var.admin_role_permissions_boundary_arn

  assume_role_policy = var.admin_role_requires_mfa ? data.aws_iam_policy_document.assume_role_with_mfa.json : data.aws_iam_policy_document.assume_role.json

  tags = var.admin_role_tags
}

resource "aws_iam_role_policy_attachment" "admin" {
  count = var.create_admin_role ? length(var.admin_role_policy_arns) : 0

  role       = aws_iam_role.admin[0].name
  policy_arn = element(var.admin_role_policy_arns, count.index)
}

# Poweruser
resource "aws_iam_role" "poweruser" {
  count = var.create_poweruser_role ? 1 : 0

  name                 = var.poweruser_role_name
  path                 = var.poweruser_role_path
  max_session_duration = var.max_session_duration

  force_detach_policies = var.force_detach_policies
  permissions_boundary  = var.poweruser_role_permissions_boundary_arn

  assume_role_policy = var.poweruser_role_requires_mfa ? data.aws_iam_policy_document.assume_role_with_mfa.json : data.aws_iam_policy_document.assume_role.json

  tags = var.poweruser_role_tags
}

resource "aws_iam_role_policy_attachment" "poweruser" {
  count = var.create_poweruser_role ? length(var.poweruser_role_policy_arns) : 0

  role       = aws_iam_role.poweruser[0].name
  policy_arn = element(var.poweruser_role_policy_arns, count.index)
}

# Readonly
resource "aws_iam_role" "readonly" {
  count = var.create_readonly_role ? 1 : 0

  name                 = var.readonly_role_name
  path                 = var.readonly_role_path
  max_session_duration = var.max_session_duration

  force_detach_policies = var.force_detach_policies
  permissions_boundary  = var.readonly_role_permissions_boundary_arn

  assume_role_policy = var.readonly_role_requires_mfa ? data.aws_iam_policy_document.assume_role_with_mfa.json : data.aws_iam_policy_document.assume_role.json

  tags = var.readonly_role_tags
}

resource "aws_iam_role_policy_attachment" "readonly" {
  count = var.create_readonly_role ? length(var.readonly_role_policy_arns) : 0

  role       = aws_iam_role.readonly[0].name
  policy_arn = element(var.readonly_role_policy_arns, count.index)
}
