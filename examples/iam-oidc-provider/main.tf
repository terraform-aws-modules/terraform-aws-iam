provider "aws" {
  region = "eu-west-1"
}

locals {
  name = "ex-${basename(path.cwd)}"

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-iam"
    GithubOrg  = "terraform-aws-modules"
  }
}

################################################################################
# OIDC Provider
# Note: This is one provider URL per AWS account
################################################################################

module "github_oidc_iam_provider" {
  source = "../../modules/iam-oidc-provider"

  tags = local.tags
}

module "oidc_iam_provider_disabled" {
  source = "../../modules/iam-oidc-provider"

  create = false
}

################################################################################
# GitHub OIDC IAM Role
################################################################################

module "github_oidc_iam_role" {
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
