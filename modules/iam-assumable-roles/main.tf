data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

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
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

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

