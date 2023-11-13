data "aws_caller_identity" "current" {
  count = var.aws_account_id == "" ? 1 : 0
}

data "aws_partition" "current" {}

locals {
  aws_account_id = try(data.aws_caller_identity.current[0].account_id, var.aws_account_id)
  partition      = data.aws_partition.current.partition
}

# Allows MFA-authenticated IAM users to manage their own credentials on the My security credentials page
# https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_aws_my-sec-creds-self-manage.html
data "aws_iam_policy_document" "iam_self_management" {
  statement {
    sid = "AllowViewAccountInfo"

    effect = "Allow"

    actions = [
      "iam:GetAccountPasswordPolicy",
      "iam:ListVirtualMFADevices"
    ]

    resources = ["*"]
  }

  statement {
    sid = "AllowManageOwnPasswords"

    effect = "Allow"

    actions = [
      "iam:ChangePassword",
      "iam:GetLoginProfile",
      "iam:GetUser",
      "iam:UpdateLoginProfile"
    ]

    resources = [
      "arn:${local.partition}:iam::${local.aws_account_id}:user/$${aws:username}",
      "arn:${local.partition}:iam::${local.aws_account_id}:user/*/$${aws:username}"
    ]
  }

  statement {
    sid = "AllowManageOwnAccessKeys"

    effect = "Allow"

    actions = [
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
      "iam:GetAccessKeyLastUsed"
    ]

    resources = [
      "arn:${local.partition}:iam::${local.aws_account_id}:user/$${aws:username}",
      "arn:${local.partition}:iam::${local.aws_account_id}:user/*/$${aws:username}"
    ]
  }

  statement {
    sid = "AllowManageOwnSigningCertificates"

    effect = "Allow"

    actions = [
      "iam:DeleteSigningCertificate",
      "iam:ListSigningCertificates",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate"
    ]

    resources = [
      "arn:${local.partition}:iam::${local.aws_account_id}:user/$${aws:username}",
      "arn:${local.partition}:iam::${local.aws_account_id}:user/*/$${aws:username}"
    ]
  }

  statement {
    sid = "AllowManageOwnSSHPublicKeys"

    effect = "Allow"

    actions = [
      "iam:DeleteSSHPublicKey",
      "iam:GetSSHPublicKey",
      "iam:ListSSHPublicKeys",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey"
    ]

    resources = [
      "arn:${local.partition}:iam::${local.aws_account_id}:user/$${aws:username}",
      "arn:${local.partition}:iam::${local.aws_account_id}:user/*/$${aws:username}"
    ]
  }

  statement {
    sid = "AllowManageOwnGitCredentials"

    effect = "Allow"

    actions = [
      "iam:CreateServiceSpecificCredential",
      "iam:DeleteServiceSpecificCredential",
      "iam:ListServiceSpecificCredentials",
      "iam:ResetServiceSpecificCredential",
      "iam:UpdateServiceSpecificCredential"
    ]

    resources = [
      "arn:${local.partition}:iam::${local.aws_account_id}:user/$${aws:username}",
      "arn:${local.partition}:iam::${local.aws_account_id}:user/*/$${aws:username}"
    ]
  }

  statement {
    sid = "AllowManageOwnVirtualMFADevice"

    effect = "Allow"

    actions = [
      "iam:CreateVirtualMFADevice"
    ]

    resources = ["arn:${local.partition}:iam::${local.aws_account_id}:mfa/*"]
  }

  statement {
    sid = "AllowManageOwnUserMFA"

    effect = "Allow"

    actions = [
      "iam:DeactivateMFADevice",
      "iam:EnableMFADevice",
      "iam:ListMFADevices",
      "iam:ResyncMFADevice"
    ]

    resources = [
      "arn:${local.partition}:iam::${local.aws_account_id}:user/$${aws:username}",
      "arn:${local.partition}:iam::${local.aws_account_id}:user/*/$${aws:username}"
    ]
  }

  dynamic "statement" {
    for_each = var.enable_mfa_enforcement ? [1] : []

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
}
