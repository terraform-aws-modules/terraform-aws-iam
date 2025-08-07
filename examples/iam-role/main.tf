provider "aws" {
  region = "eu-west-1"
}

data "aws_caller_identity" "current" {}

locals {
  name = "ex-${basename(path.cwd)}"

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-iam"
    GithubOrg  = "terraform-aws-modules"
  }
}

################################################################################
# IAM Role
################################################################################

module "iam_role_instance_profile" {
  source = "../../modules/iam-role"

  name = "${local.name}-instance-profile"

  # https://aws.amazon.com/blogs/security/announcing-an-update-to-iam-role-trust-policy-behavior/
  allow_self_assume_role  = true
  create_instance_profile = true

  assume_role_policy_statements = [
    {
      sid = "TrustRoleAndServiceToAssume"
      principals = [
        {
          type = "AWS"
          identifiers = [
            "arn:aws:iam::307990089504:root",
            "arn:aws:iam::835367859851:user/anton",
          ]
        },
        {
          type = "Service"
          identifiers = [
            "codedeploy.amazonaws.com",
          ]
        }
      ]
    }
  ]

  policies = {
    ReadOnlyAccess = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  }

  tags = local.tags
}

module "iam_role_conditions" {
  source = "../../modules/iam-role"

  name_prefix = "conditions-"

  assume_role_policy_statements = [
    {
      sid = "TrustRoleAndServiceToAssume"
      principals = [{
        type = "AWS"
        identifiers = [
          "arn:aws:iam::835367859851:user/anton",
        ]
      }]
      conditions = [{
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = ["some-secret-id"]
      }]
    }
  ]

  policies = {
    AmazonCognitoReadOnly      = "arn:aws:iam::aws:policy/AmazonCognitoReadOnly"
    AlexaForBusinessFullAccess = "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess"
    custom                     = aws_iam_policy.this.arn
  }

  tags = local.tags
}

module "iam_roles" {
  source = "../../modules/iam-role"

  for_each = {
    admin = {
      trusted_arns = [data.aws_caller_identity.current.arn]
      policies = {
        AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
      }
    }
    readonly = {
      trusted_arns = ["arn:aws:iam::835367859851:user/anton"]
      policies = {
        ReadOnlyAccess = "arn:aws:iam::aws:policy/ReadOnlyAccess"
      }
    }
    poweruser = {
      trusted_arns    = [data.aws_caller_identity.current.arn]
      PowerUserAccess = "arn:aws:iam::aws:policy/PowerUserAccess"
    }
  }

  name_prefix = "${each.key}-"

  assume_role_policy_statements = [
    {
      sid = "TrustRoleAndServiceToAssume"
      principals = [{
        type        = "AWS"
        identifiers = each.value.trusted_arns
      }]

      conditions = [
        {
          test     = "Bool"
          variable = "aws:MultiFactorAuthPresent"
          values   = ["true"]
        },
        {
          test     = "NumericLessThan"
          variable = "aws:MultiFactorAuthAge"
          values   = [86400]
        }
      ]
    }
  ]

  policies = each.value.policies

  tags = local.tags
}

module "iam_role_disabled" {
  source = "../../modules/iam-role"

  create = false
}

################################################################################
# Supporting resources
################################################################################

resource "aws_iam_policy" "this" {
  name        = local.name
  path        = "/"
  description = "Example policy"

  policy = <<-EOT
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": [
            "ec2:Describe*"
          ],
          "Effect": "Allow",
          "Resource": "*"
        }
      ]
    }
  EOT

  tags = local.tags
}
