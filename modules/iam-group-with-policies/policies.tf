data "aws_caller_identity" "current" {
  count = var.aws_account_id == "" ? 1 : 0
}

locals {
  aws_account_id = element(
    concat(
      data.aws_caller_identity.current.*.account_id,
      [var.aws_account_id],
    ),
    0,
  )
}

data "aws_iam_policy_document" "iam_self_management" {
  statement {
    sid = "AllowSelfManagement"

    effect = "Allow"

    actions = [
      "iam:ChangePassword",
      "iam:CreateAccessKey",
      "iam:CreateLoginProfile",
      "iam:CreateVirtualMFADevice",
      "iam:DeleteAccessKey",
      "iam:DeleteLoginProfile",
      "iam:DeleteVirtualMFADevice",
      "iam:EnableMFADevice",
      "iam:GenerateCredentialReport",
      "iam:GenerateServiceLastAccessedDetails",
      "iam:Get*",
      "iam:List*",
      "iam:ResyncMFADevice",
      "iam:UpdateAccessKey",
      "iam:UpdateLoginProfile",
      "iam:UpdateUser",
      "iam:UploadSigningCertificate",
      "iam:UploadSSHPublicKey",
    ]

    # Allow for both users with "path" and without it
    resources = [
      "arn:aws:iam::${local.aws_account_id}:user/*/$${aws:username}",
      "arn:aws:iam::${local.aws_account_id}:user/$${aws:username}",
      "arn:aws:iam::${local.aws_account_id}:mfa/$${aws:username}",
    ]
  }

  statement {
    sid = "AllowIAMReadOnly"

    actions = [
      "iam:Get*",
      "iam:List*",
    ]

    resources = ["*"]
    effect    = "Allow"
  }

  # Allow to deactivate MFA only when logging in with MFA
  statement {
    sid = "AllowDeactivateMFADevice"

    effect = "Allow"

    actions = [
      "iam:DeactivateMFADevice",
    ]

    # Allow for both users with "path" and without it
    resources = [
      "arn:aws:iam::${local.aws_account_id}:user/*/$${aws:username}",
      "arn:aws:iam::${local.aws_account_id}:user/$${aws:username}",
      "arn:aws:iam::${local.aws_account_id}:mfa/$${aws:username}",
    ]

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }

    condition {
      test     = "NumericLessThan"
      variable = "aws:MultiFactorAuthAge"
      values   = ["3600"]
    }
  }
}

