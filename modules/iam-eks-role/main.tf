data "aws_iam_policy_document" "assume_role_with_oidc" {
  count = var.create_role ? 1 : 0

  dynamic "statement" {
    for_each = var.oidc_providers

    content {
      effect  = "Allow"
      actions = ["sts:AssumeRoleWithWebIdentity"]

      principals {
        type        = "Federated"
        identifiers = statement.value.provider_arns
      }

      condition {
        test     = "StringEquals"
        variable = "${statement.value.provider}:sub"
        values   = [for sa in statement.value.service_accounts : "system:serviceaccount:${sa}"]
      }
    }
  }
}

resource "aws_iam_role" "this" {
  count = var.create_role ? 1 : 0

  name        = var.role_name
  name_prefix = var.role_name_prefix
  path        = var.role_path
  description = var.role_description

  assume_role_policy    = data.aws_iam_policy_document.assume_role_with_oidc[0].json
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.role_permissions_boundary_arn
  force_detach_policies = var.force_detach_policies

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "custom" {
  for_each   = var.create_role ? toset(var.role_policy_arns) : []
  role       = aws_iam_role.this[0].name
  policy_arn = each.key
}
