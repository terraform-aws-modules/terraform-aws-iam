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
      trusted_arns = [data.aws_caller_identity.current.arn]
      policies = {
        PowerUserAccess = "arn:aws:iam::aws:policy/PowerUserAccess"
      }
    }
  }

  name = each.key

  trust_policy_permissions = {
    TrustRoleAndServiceToAssume = {
      actions = [
        "sts:AssumeRole",
        "sts:TagSession",
      ]
      principals = [{
        type        = "AWS"
        identifiers = each.value.trusted_arns
      }]

      condition = [
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
  }

  policies = each.value.policies

  tags = local.tags
}

module "iam_role_disabled" {
  source = "../../modules/iam-role"

  create = false
}

################################################################################
# IAM Role - Instance Profile
################################################################################

module "iam_role_instance_profile" {
  source = "../../modules/iam-role"

  name = "${local.name}-instance-profile"

  create_instance_profile = true

  trust_policy_permissions = {
    TrustRoleAndServiceToAssume = {
      actions = [
        "sts:AssumeRole",
        "sts:TagSession",
      ]
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
  }

  policies = {
    ReadOnlyAccess = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  }

  tags = local.tags
}

################################################################################
# IAM Role - GitHub OIDC
################################################################################

module "iam_role_github_oidc" {
  source = "../../modules/iam-role"

  name = local.name

  enable_github_oidc = true

  # This should be updated to suit your organization, repository, references/branches, etc.
  oidc_subjects = [
    # You can prepend with `repo:` but it is not required
    "repo:terraform-aws-modules/terraform-aws-iam:pull_request",
    "terraform-aws-modules/terraform-aws-iam:ref:refs/heads/master",
  ]

  policies = {
    S3ReadOnly = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  }

  tags = local.tags
}

################################################################################
# IAM Role - CircleCI OIDC
################################################################################

module "iam_role_circleci_oidc" {
  source = "../../modules/iam-role"

  name = local.name

  enable_oidc        = true
  oidc_provider_urls = ["oidc.circleci.com/org/<CIRCLECI_ORG_UUID>"]
  oidc_audiences     = ["<CIRCLECI_ORG_UUID>"]

  policies = {
    AmazonEC2ContainerRegistryPowerUser = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
  }

  tags = local.tags
}

################################################################################
# IAM Role - SAML 2.0
################################################################################

module "iam_role_saml" {
  source = "../../modules/iam-role"

  name = "${local.name}-saml"

  enable_saml       = true
  saml_provider_ids = [aws_iam_saml_provider.this.id]

  policies = {
    ReadOnlyAccess = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  }

  tags = local.tags
}

################################################################################
# IAM Role - Inline Policy
################################################################################

module "iam_role_inline_policy" {
  source = "../../modules/iam-role"

  name = "${local.name}-inline-policy"

  create_instance_profile = true

  trust_policy_permissions = {
    ec2 = {
      effect = "Allow"
      actions = [
        "sts:AssumeRole"
      ]
      principals = [{
        type        = "Service"
        identifiers = ["ec2.amazonaws.com"]
      }]
    }
  }

  create_inline_policy = true
  inline_policy_permissions = {
    S3ReadAccess = {
      effect = "Allow"
      actions = [
        "s3:GetObject",
        "s3:ListBucket"
      ]
      resources = [
        "arn:aws:s3:::example-bucket",
        "arn:aws:s3:::example-bucket/*"
      ]
    }
  }

  tags = local.tags
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

resource "aws_iam_saml_provider" "this" {
  name                   = "idp_saml"
  saml_metadata_document = file("saml-metadata.xml")
}
