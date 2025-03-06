provider "aws" {
  region = local.region
}

locals {
  name   = "ex-iam-github-oidc"
  region = "eu-west-1"

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-iam"
    GithubOrg  = "terraform-aws-modules"
  }
}

################################################################################
# GitHub OIDC Provider
# Note: This is one per AWS account
################################################################################

module "iam_github_oidc_provider" {
  source = "../../modules/iam-github-oidc-provider"

  tags = local.tags
}

module "iam_github_oidc_provider_disabled" {
  source = "../../modules/iam-github-oidc-provider"

  create = false
}

################################################################################
# GitHub OIDC Role
################################################################################

module "iam_github_oidc_role" {
  source = "../../modules/iam-github-oidc-role"

  name = local.name

  # This should be updated to suit your organization, repository, references/branches, etc.
  subjects = [
    # You can prepend with `repo:` but it is not required
    "repo:terraform-aws-modules/terraform-aws-iam:pull_request",
    "terraform-aws-modules/terraform-aws-iam:ref:refs/heads/master",
  ]

  # As per the Github documentation for security hardening with OpenID Connect
  # (https://docs.github.com/en/actions/security-for-github-actions/security-hardening-your-deployments/about-security-hardening-with-openid-connect)
  # This document makes many references to the fact that you can leverage any of the available
  # OIDC claims to when configuring the cloud providers trust relation. For example in
  # https://docs.github.com/en/actions/security-for-github-actions/security-hardening-your-deployments/about-security-hardening-with-openid-connect#customizing-the-token-claims
  # it is specified that granular OIDC policies can be defined using additional OIDC token claims.
  # In this example, we ensure that the OIDC token GitHub uses to assume the AWS IAM role has the correct
  # `actor` scope.
  additional_trust_policy_conditions = [
    {
      test     = "StringEquals"
      variable = "${module.iam_github_oidc_provider.url}:actor"
      # This should be the list of GitHub usernames for which you want to restrict
      # access to the role.
      values = ["username"]
    }
  ]

  policies = {
    additional = aws_iam_policy.additional.arn
    S3ReadOnly = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  }

  tags = local.tags
}

module "iam_github_oidc_role_disabled" {
  source = "../../modules/iam-github-oidc-role"

  create = false
}

################################################################################
# Supporting Resources
################################################################################

resource "aws_iam_policy" "additional" {
  name        = "${local.name}-additional"
  description = "Additional test policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

  tags = local.tags
}
