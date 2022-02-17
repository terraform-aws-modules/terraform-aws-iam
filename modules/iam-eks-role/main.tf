data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_eks_cluster" "main" {
  for_each = var.cluster_service_accounts

  name = each.key
}

data "aws_iam_policy_document" "assume_role_with_oidc" {
  dynamic "statement" {
    for_each = var.cluster_service_accounts

    content {
      effect = "Allow"

      actions = ["sts:AssumeRoleWithWebIdentity"]

      principals {
        type = "Federated"

        identifiers = [
          "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(data.aws_eks_cluster.main[statement.key].identity[0].oidc[0].issuer, "https://", "")}"
        ]
      }

      condition {
        test     = "StringEquals"
        variable = "${replace(data.aws_eks_cluster.main[statement.key].identity[0].oidc[0].issuer, "https://", "")}:sub"
        values   = [for s in statement.value : "system:serviceaccount:${s}"]
      }
    }
  }

  dynamic "statement" {
    for_each = var.provider_url_sa_pairs

    content {
      effect = "Allow"

      actions = ["sts:AssumeRoleWithWebIdentity"]

      principals {
        type = "Federated"

        identifiers = [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${statement.key}"
        ]
      }

      condition {
        test     = "StringEquals"
        variable = "${statement.key}:sub"
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

resource "aws_iam_role_policy_attachment" "custom" {
  for_each = toset([for arn in var.role_policy_arns : arn if var.create_role])

  role       = aws_iam_role.this[0].name
  policy_arn = each.key
}
