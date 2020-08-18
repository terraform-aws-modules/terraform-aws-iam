locals {
  aws_account_id = var.aws_account_id != "" ? var.aws_account_id : data.aws_caller_identity.current.account_id
  # clean URLs of https:// prefix
  urls = [
    for url in distinct(concat(var.provider_urls, [var.provider_url])) :
    replace(url, "https://", "")
  ]
  identifiers = [
    for url in local.urls :
    "arn:${data.aws_partition.current.partition}:iam::${local.aws_account_id}:oidc-provider/${url}"
  ]
}

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_iam_policy_document" "assume_role_with_oidc" {
  count = var.create_role ? 1 : 0

  statement {
    effect = "Allow"

    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type = "Federated"

      identifiers = local.identifiers
    }

    dynamic "condition" {
      for_each = length(var.oidc_fully_qualified_subjects) > 0 ? local.urls : []
      content {
        test     = "StringEquals"
        variable = "${condition.value}:sub"
        values   = var.oidc_fully_qualified_subjects
      }
    }


    dynamic "condition" {
      for_each = length(var.oidc_subjects_with_wildcards) > 0 ? local.urls : []
      content {
        test     = "StringLike"
        variable = "${condition.value}:sub"
        values   = var.oidc_subjects_with_wildcards
      }
    }
  }
}

resource "aws_iam_role" "this" {
  count = var.create_role ? 1 : 0

  name                 = var.role_name
  path                 = var.role_path
  max_session_duration = var.max_session_duration

  force_detach_policies = var.force_detach_policies
  permissions_boundary  = var.role_permissions_boundary_arn

  assume_role_policy = join("", data.aws_iam_policy_document.assume_role_with_oidc.*.json)

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "custom" {
  count = var.create_role && length(var.role_policy_arns) > 0 ? length(var.role_policy_arns) : 0

  role       = join("", aws_iam_role.this.*.name)
  policy_arn = var.role_policy_arns[count.index]
}
