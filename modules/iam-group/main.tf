data "aws_partition" "current" {
  count = var.create ? 1 : 0
}

data "aws_caller_identity" "current" {
  count = var.create ? 1 : 0
}

locals {
  partition        = try(data.aws_partition.current[0].partition, "")
  users_account_id = try(coalesce(var.users_account_id, data.aws_caller_identity.current[0].account_id), "")

  user_resources = [for pattern in ["user/$${aws:username}", "user/*/$${aws:username}"] :
    "arn:${local.partition}:iam::${local.users_account_id}:${pattern}"
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
  create_policy = var.create && var.create_policy && (var.enable_self_management_permissions || var.permissions != null)

  policy_name = try(coalesce(var.policy_name, var.name), "")
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
        "iam:GetAccountSummary",
        "iam:GetAccountPasswordPolicy",
        "iam:ListAccountAliases",
        "iam:ListVirtualMFADevices",
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
        "iam:GetLoginProfile",
        "iam:GetUser",
        "iam:UpdateLoginProfile",
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
        "iam:UpdateAccessKey",
        "iam:GetAccessKeyLastUsed",
        "iam:TagUser",
        "iam:ListUserTags",
        "iam:UntagUser",
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
      resources = ["arn:${local.partition}:iam::${local.users_account_id}:mfa/*"]
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
    for_each = var.enable_self_management_permissions && var.enable_mfa_enforcement ? [1] : []

    content {
      sid    = "DenyAllExceptListedIfNoMFA"
      effect = "Deny"
      not_actions = [
        "iam:CreateVirtualMFADevice",
        "iam:EnableMFADevice",
        "iam:GetUser",
        "iam:GetMFADevice",
        "iam:ListMFADevices",
        "iam:ListVirtualMFADevices",
        "iam:ResyncMFADevice",
        "sts:GetSessionToken",
        "iam:ChangePassword",
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

resource "aws_iam_policy" "this" {
  count = local.create_policy ? 1 : 0

  description = var.policy_description
  name        = var.policy_use_name_prefix ? null : local.policy_name
  name_prefix = var.policy_use_name_prefix ? "${local.policy_name}-" : null
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
