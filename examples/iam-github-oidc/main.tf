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
# GitHub OIDC Role w/ fine-grained job_workflow_refs
################################################################################

module "iam_github_oidc_job_workflow_refs" {
  source = "../../modules/iam-github-oidc-role"

  name   = "${local.name}-job-workflow-refs"
  create = true

  policies = {
    S3ReadOnly = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  }

  # We can still say "I only want these repos to be the only principals"
  subjects = [
    "repo:terraform-aws-modules/terraform-aws-iam:pull_request",
    "terraform-aws-modules/terraform-aws-iam:ref:refs/heads/master",
  ]

  # But we can now say "Only allow them to be the principal if they're running an approved workflow from this branch"
  job_workflow_refs = [
    "terraform-aws-modules/terraform-aws-iam/.github/workflows/pre-commit.yml@refs/heads/main",
    "terraform-aws-modules/terraform-aws-iam/.github/workflows/pr-title@refs/heads/main",
  ]
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
