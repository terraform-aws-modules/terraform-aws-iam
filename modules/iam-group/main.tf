data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}

locals {
  users_account_id = coalesce(var.users_account_id, data.aws_caller_identity.current.account_id)

  user_resources = [for pattern in ["user/$${aws:username}", "user/*/$${aws:username}"] :
    "arn:${data.aws_partition.current.partition}:iam::${local.users_account_id}:${pattern}"
  ]
}

################################################################################
# IAM Group
################################################################################

resource "aws_iam_group" "this" {
  count = var.create ? 1 : 0

  name = var.name
  path = var.path
}

resource "aws_iam_group_membership" "this" {
  count = var.create && length(var.users) > 0 ? 1 : 0

  group = aws_iam_group.this[0].id
  name  = var.name
  users = var.users
}

################################################################################
# IAM Group Policy
################################################################################

locals {
  create_policy = var.create && var.create_policy && (var.enable_self_management_permissions || length(var.permission_statements) > 0)
}

# Allows MFA-authenticated IAM users to manage their own credentials on the My security credentials page
# https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_aws_my-sec-creds-self-manage.html
data "aws_iam_policy_document" "this" {
  count = local.create_policy ? 1 : 0

  dynamic "statement" {
    for_each = var.enable_self_management_permissions ? [1] : []

    content {
      sid = "ViewAccountInfo"
      actions = [
        "iam:GetAccountPasswordPolicy",
        "iam:ListVirtualMFADevices"
      ]
      resources = ["*"]
    }
  }

  dynamic "statement" {
    for_each = var.enable_self_management_permissions ? [1] : []

    content {
      sid = "ManageOwnPasswords"
      actions = [
        "iam:ChangePassword",
        "iam:GetUser"
      ]
      resources = local.user_resources
    }
  }

  dynamic "statement" {
    for_each = var.enable_self_management_permissions ? [1] : []

    content {
      sid = "ManageOwnAccessKeys"
      actions = [
        "iam:CreateAccessKey",
        "iam:DeleteAccessKey",
        "iam:ListAccessKeys",
        "iam:UpdateAccessKey"
      ]
      resources = local.user_resources
    }
  }

  dynamic "statement" {
    for_each = var.enable_self_management_permissions ? [1] : []

    content {
      sid = "ManageOwnSigningCertificates"
      actions = [
        "iam:DeleteSigningCertificate",
        "iam:ListSigningCertificates",
        "iam:UpdateSigningCertificate",
        "iam:UploadSigningCertificate"
      ]
      resources = local.user_resources
    }
  }

  dynamic "statement" {
    for_each = var.enable_self_management_permissions ? [1] : []

    content {
      sid = "ManageOwnSSHPublicKeys"
      actions = [
        "iam:DeleteSSHPublicKey",
        "iam:GetSSHPublicKey",
        "iam:ListSSHPublicKeys",
        "iam:UpdateSSHPublicKey",
        "iam:UploadSSHPublicKey"
      ]
      resources = local.user_resources
    }
  }

  dynamic "statement" {
    for_each = var.enable_self_management_permissions ? [1] : []

    content {
      sid = "ManageOwnGitCredentials"
      actions = [
        "iam:CreateServiceSpecificCredential",
        "iam:DeleteServiceSpecificCredential",
        "iam:ListServiceSpecificCredentials",
        "iam:ResetServiceSpecificCredential",
        "iam:UpdateServiceSpecificCredential"
      ]
      resources = local.user_resources
    }
  }

  dynamic "statement" {
    for_each = var.enable_self_management_permissions ? [1] : []

    content {
      sid       = "ManageOwnVirtualMFADevice"
      actions   = ["iam:CreateVirtualMFADevice"]
      resources = ["arn:${data.aws_partition.current.partition}:iam::${local.users_account_id}:mfa/*"]
    }
  }

  dynamic "statement" {
    for_each = var.enable_self_management_permissions ? [1] : []

    content {
      sid = "ManageOwnUserMFA"
      actions = [
        "iam:DeactivateMFADevice",
        "iam:EnableMFADevice",
        "iam:ListMFADevices",
        "iam:ResyncMFADevice"
      ]
      resources = local.user_resources
    }
  }

  dynamic "statement" {
    for_each = var.enable_self_management_permissions && var.enable_mfa_enforcment ? [1] : []

    content {
      sid = "DenyAllExceptListedIfNoMFA"
      not_actions = [
        "iam:ChangePassword",
        "iam:CreateVirtualMFADevice",
        "iam:EnableMFADevice",
        "iam:GetUser",
        "iam:ListMFADevices",
        "iam:ListVirtualMFADevices",
        "iam:ResyncMFADevice",
        "sts:GetSessionToken"
      ]
      resources = ["*"]

      condition {
        test     = "BoolIfExists"
        variable = "aws:MultiFactorAuthPresent"
        values   = ["false"]
      }
    }
  }

  dynamic "statement" {
    for_each = var.permission_statements

    content {
      sid           = try(statement.value.sid, null)
      actions       = try(statement.value.actions, null)
      not_actions   = try(statement.value.not_actions, null)
      effect        = try(statement.value.effect, null)
      resources     = try(statement.value.resources, null)
      not_resources = try(statement.value.not_resources, null)

      dynamic "principals" {
        for_each = try(statement.value.principals, [])

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = try(statement.value.not_principals, [])

        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = try(statement.value.conditions, [])

        content {
          test     = condition.value.test
          values   = condition.value.values
          variable = condition.value.variable
        }
      }
    }
  }
}

resource "aws_iam_policy" "this" {
  count = local.create_policy ? 1 : 0

  name_prefix = try(coalesce(var.policy_name_prefix, "${var.name}-"), null)
  description = var.policy_description
  path        = coalesce(var.policy_path, var.path, "/")
  policy      = data.aws_iam_policy_document.this[0].json

  tags = var.tags
}

resource "aws_iam_group_policy_attachment" "this" {
  count = local.create_policy ? 1 : 0

  group      = aws_iam_group.this[0].id
  policy_arn = aws_iam_policy.this[0].arn
}

resource "aws_iam_group_policy_attachment" "additional" {
  for_each = { for k, v in var.policies : k => v if var.create }

  group      = aws_iam_group.this[0].id
  policy_arn = each.value
}
