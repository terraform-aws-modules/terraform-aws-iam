data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id          = data.aws_caller_identity.current.account_id
  partition           = data.aws_partition.current.partition
  dns_suffix          = data.aws_partition.current.dns_suffix
  region              = data.aws_region.current.name
  role_name_condition = var.role_name != null ? var.role_name : "${var.role_name_prefix}*"
}

data "aws_iam_policy_document" "this" {
  count = var.create_role ? 1 : 0

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
    for_each = var.oidc_providers

    content {
      effect  = "Allow"
      actions = ["sts:AssumeRoleWithWebIdentity"]

      principals {
        type        = "Federated"
        identifiers = [statement.value.provider_arn]
      }

      condition {
        test     = var.assume_role_condition_test
        variable = "${replace(statement.value.provider_arn, "/^(.*provider/)/", "")}:sub"
        values   = [for sa in statement.value.namespace_service_accounts : "system:serviceaccount:${sa}"]
      }

      # https://aws.amazon.com/premiumsupport/knowledge-center/eks-troubleshoot-oidc-and-irsa/?nc1=h_ls
      condition {
        test     = var.assume_role_condition_test
        variable = "${replace(statement.value.provider_arn, "/^(.*provider/)/", "")}:aud"
        values   = ["sts.amazonaws.com"]
      }

    }
  }

  # https://docs.aws.amazon.com/eks/latest/userguide/pod-identities.html
  dynamic "statement" {
    for_each = var.assume_role_pod_identity ? toset([1]) : toset([])
    content {
      effect  = "Allow"
      actions = ["sts:TagSession", "sts:AssumeRole"]

      principals {
        type        = "Service"
        identifiers = ["pods.eks.amazonaws.com"]
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

  assume_role_policy    = data.aws_iam_policy_document.this[0].json
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.role_permissions_boundary_arn
  force_detach_policies = var.force_detach_policies

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = { for k, v in var.role_policy_arns : k => v if var.create_role }

  role       = aws_iam_role.this[0].name
  policy_arn = each.value
}

################################################################################
# Pod Identity associations
################################################################################

locals {
  create_pod_identity_associations = var.create_role && var.assume_role_pod_identity
  pod_identity_associations = flatten([
    for cluster_name, identities in var.pod_identities :
    [
      for namespace, service_accounts in identities :
      [
        for name in service_accounts :
        {
          cluster_name    = cluster_name
          namespace       = namespace
          service_account = name
        }
      ]
    ]
    if local.create_pod_identity_associations
  ])
}

resource "aws_eks_pod_identity_association" "this" {
  count           = length(local.pod_identity_associations)
  cluster_name    = local.pod_identity_associations[count.index].cluster_name
  namespace       = local.pod_identity_associations[count.index].namespace
  service_account = local.pod_identity_associations[count.index].service_account
  role_arn        = aws_iam_role.this[0].arn
}
