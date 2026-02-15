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

module "private_gitlab_oidc_iam_provider" {
  source = "../../modules/iam-oidc-provider"

  # https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc_verify-thumbprint.html#oidc-obtain-thumbprint explains how to obtain thumbprints using openssl.
  thumbprint_list = ["ae801ed1c55bb579d79208b0d772acfb8cc3a208"]
  url             = "https://example.com"

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

  name = "${local.name}-github"

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

module "private_gitlab_oidc_iam_role" {
  source = "../../modules/iam-role"

  name = "${local.name}-private-gitlab"

  enable_oidc        = true
  oidc_provider_urls = [module.private_gitlab_oidc_iam_provider.url]

  # This should be updated to suit your organization, repository, references/branches, etc.
  oidc_subjects = [
    "project_path:mygroup/myproject:ref_type:branch:ref:main",
  ]

  policies = {
    S3ReadOnly = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  }

  tags = local.tags
}
