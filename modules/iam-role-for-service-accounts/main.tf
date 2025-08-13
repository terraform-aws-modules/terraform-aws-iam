data "aws_partition" "current" {
  count = var.create ? 1 : 0
}

locals {
  partition  = try(data.aws_partition.current[0].partition, "")
  dns_suffix = try(data.aws_partition.current[0].dns_suffix, "")
}

################################################################################
# IAM Role
################################################################################

data "aws_iam_policy_document" "assume" {
  count = var.create ? 1 : 0

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
        test     = var.trust_condition_test
        variable = "${replace(statement.value.provider_arn, "/^(.*provider/)/", "")}:sub"
        values   = [for sa in statement.value.namespace_service_accounts : "system:serviceaccount:${sa}"]
      }

      # https://aws.amazon.com/premiumsupport/knowledge-center/eks-troubleshoot-oidc-and-irsa/?nc1=h_ls
      condition {
        test     = var.trust_condition_test
        variable = "${replace(statement.value.provider_arn, "/^(.*provider/)/", "")}:aud"
        values   = ["sts.amazonaws.com"]
      }
    }
  }
}

resource "aws_iam_role" "this" {
  count = var.create ? 1 : 0

  name        = var.use_name_prefix ? null : var.name
  name_prefix = var.use_name_prefix ? "${var.name}-" : null
  path        = var.path
  description = var.description

  assume_role_policy    = data.aws_iam_policy_document.assume[0].json
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.permissions_boundary
  force_detach_policies = true

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "additional" {
  for_each = { for k, v in var.policies : k => v if var.create }

  role       = aws_iam_role.this[0].name
  policy_arn = each.value
}

################################################################################
# IAM Policy
################################################################################

locals {
  create_policy = var.create && var.create_policy

  source_policy_documents = flatten(concat(
    data.aws_iam_policy_document.aws_gateway_controller[*].json,
    data.aws_iam_policy_document.cert_manager[*].json,
    data.aws_iam_policy_document.cluster_autoscaler[*].json,
    data.aws_iam_policy_document.ebs_csi[*].json,
    data.aws_iam_policy_document.efs_csi[*].json,
    data.aws_iam_policy_document.mountpoint_s3_csi[*].json,
    data.aws_iam_policy_document.external_dns[*].json,
    data.aws_iam_policy_document.external_secrets[*].json,
    data.aws_iam_policy_document.fsx_lustre_csi[*].json,
    data.aws_iam_policy_document.fsx_openzfs_csi[*].json,
    data.aws_iam_policy_document.load_balancer_controller[*].json,
    data.aws_iam_policy_document.load_balancer_controller_targetgroup_only[*].json,
    data.aws_iam_policy_document.amazon_managed_service_prometheus[*].json,
    data.aws_iam_policy_document.node_termination_handler[*].json,
    data.aws_iam_policy_document.velero[*].json,
    data.aws_iam_policy_document.vpc_cni[*].json,
    var.source_policy_documents,
  ))
}

data "aws_iam_policy_document" "this" {
  count = local.create_policy ? 1 : 0

  source_policy_documents   = local.source_policy_documents
  override_policy_documents = var.override_policy_documents

  dynamic "statement" {
    for_each = var.permissions != null ? var.permissions : {}

    content {
      sid           = try(coalesce(statement.value.sid, statement.key))
      actions       = statement.value.actions
      not_actions   = statement.value.not_actions
      effect        = statement.value.effect
      resources     = statement.value.resources
      not_resources = statement.value.not_resources

      dynamic "principals" {
        for_each = statement.value.principals != null ? statement.value.principals : []

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = statement.value.not_principals != null ? statement.value.not_principals : []

        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = statement.value.condition != null ? statement.value.condition : []

        content {
          test     = condition.value.test
          values   = condition.value.values
          variable = condition.value.variable
        }
      }
    }
  }
}

locals {
  policy_name = try(coalesce(var.policy_name, var.name), "")
}

resource "aws_iam_policy" "this" {
  count = local.create_policy ? 1 : 0

  name        = var.use_name_prefix ? null : local.policy_name
  name_prefix = var.use_name_prefix ? "${local.policy_name}-" : null
  path        = coalesce(var.policy_path, var.path)
  description = try(coalesce(var.policy_description, var.description), null)
  policy      = data.aws_iam_policy_document.this[0].json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "this" {
  count = local.create_policy ? 1 : 0

  role       = aws_iam_role.this[0].name
  policy_arn = aws_iam_policy.this[0].arn
}

################################################################################
# IAM Role Inline policy
################################################################################

locals {
  create_iam_role_inline_policy = var.create && var.create_inline_policy
}

data "aws_iam_policy_document" "inline" {
  count = local.create_iam_role_inline_policy ? 1 : 0

  source_policy_documents   = var.source_inline_policy_documents
  override_policy_documents = var.override_inline_policy_documents

  dynamic "statement" {
    for_each = var.inline_policy_permissions != null ? var.inline_policy_permissions : {}

    content {
      sid           = try(coalesce(statement.value.sid, statement.key))
      actions       = statement.value.actions
      not_actions   = statement.value.not_actions
      effect        = statement.value.effect
      resources     = statement.value.resources
      not_resources = statement.value.not_resources

      dynamic "principals" {
        for_each = statement.value.principals != null ? statement.value.principals : []

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = statement.value.not_principals != null ? statement.value.not_principals : []

        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = statement.value.condition != null ? statement.value.condition : []

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
  name        = var.use_name_prefix ? null : var.name
  name_prefix = var.use_name_prefix ? "${var.name}-" : null
  policy      = data.aws_iam_policy_document.inline[0].json
}
