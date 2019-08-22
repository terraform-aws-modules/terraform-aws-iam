locals {
  # default, fallback policy for all roles
  default_assume_role_json          = data.aws_iam_policy_document.default_assume_role.json
  default_assume_role_with_mfa_json = data.aws_iam_policy_document.default_assume_role_with_mfa.json

  # admin specific policy and default fallback
  admin_custom_assume_role_json  = var.admin_role_requires_mfa ? data.aws_iam_policy_document.admin_assume_role_with_mfa[0].json : data.aws_iam_policy_document.admin_assume_role[0].json
  admin_default_assume_role_json = var.admin_role_requires_mfa ? local.default_assume_role_with_mfa_json : local.default_assume_role_json

  # poweruser specific policy and default fallback
  poweruser_custom_assume_role_json  = var.poweruser_role_requires_mfa ? data.aws_iam_policy_document.poweruser_assume_role_with_mfa[0].json : data.aws_iam_policy_document.poweruser_assume_role[0].json
  poweruser_default_assume_role_json = var.poweruser_role_requires_mfa ? local.default_assume_role_with_mfa_json : local.default_assume_role_json

  # readonly specific policy and default fallback
  readonly_custom_assume_role_json  = var.readonly_role_requires_mfa ? data.aws_iam_policy_document.readonly_assume_role_with_mfa[0].json : data.aws_iam_policy_document.readonly_assume_role[0].json
  readonly_default_assume_role_json = var.readonly_role_requires_mfa ? local.default_assume_role_with_mfa_json : local.default_assume_role_json
}

# Admin
resource "aws_iam_role" "admin" {
  count = var.create_admin_role ? 1 : 0

  name                 = var.admin_role_name
  path                 = var.admin_role_path
  max_session_duration = var.max_session_duration

  permissions_boundary = var.admin_role_permissions_boundary_arn

  assume_role_policy = var.use_custom_admin_role_trust ? local.admin_custom_assume_role_json : local.admin_default_assume_role_json

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

  permissions_boundary = var.poweruser_role_permissions_boundary_arn

  assume_role_policy = var.use_custom_poweruser_role_trust ? local.poweruser_custom_assume_role_json : local.poweruser_default_assume_role_json

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

  permissions_boundary = var.readonly_role_permissions_boundary_arn

  assume_role_policy = var.use_custom_readonly_role_trust ? local.readonly_custom_assume_role_json : local.readonly_default_assume_role_json

  tags = var.readonly_role_tags
}

resource "aws_iam_role_policy_attachment" "readonly" {
  count = var.create_readonly_role ? length(var.readonly_role_policy_arns) : 0

  role       = aws_iam_role.readonly[0].name
  policy_arn = element(var.readonly_role_policy_arns, count.index)
}

