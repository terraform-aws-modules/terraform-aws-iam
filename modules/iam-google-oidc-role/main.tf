data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}

locals {
  # Just extra safety incase someone passes in a url with `https://`
  provider_url = replace(var.provider_url, "https://", "")

  account_id = data.aws_caller_identity.current.account_id
  partition  = data.aws_partition.current.partition
}

################################################################################
# Google OIDC Role
################################################################################

data "aws_iam_policy_document" "this" {
  count = var.create ? 1 : 0

  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type        = "Federated"
      identifiers = [local.provider_url]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.provider_url}:iss"
      values   = "https://${local.provider_url}"
    }

    condition {
      test     = "ForAllValues:StringEquals"
      variable = "${local.provider_url}:sub"
      values   = var.google_service_account_ids
    }

    condition {
      test     = "ForAllValues:StringEquals"
      variable = "${local.provider_url}:email"
      values   = var.google_service_account_emails
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
