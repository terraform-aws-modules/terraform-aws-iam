provider "aws" {
  region = local.region
}

locals {
  name   = "ex-iam-bitbucket-oidc"
  region = "eu-west-1"

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-iam"
    GithubOrg  = "terraform-aws-modules"
  }
}

################################################################################
# Bitbucket OIDC Provider
# Note: This is one per AWS account
################################################################################

module "iam_bitbucket_oidc_provider" {
  source = "../../modules/iam-bitbucket-oidc-provider"

  client_id_list = ["ari:cloud:bitbucket::workspace/5df1fe21-3e92-4e32-ad7b-6ab3114afe0b"]
  tags           = local.tags
}

module "iam_bitbucket_oidc_provider_disabled" {
  source = "../../modules/iam-bitbucket-oidc-provider"

  create = false
}

################################################################################
# Bitbucket OIDC Role
################################################################################

module "iam_bitbucket_oidc_role" {
  source = "../../modules/iam-bitbucket-oidc-role"

  name = local.name

  # These should be updated to suit your workspace, repository, environment, and step UUIDs

  # audience can be defined as "ari:cloud:bitbucket::workspace/WORKSPACE_UUID"
  audience = "ari:cloud:bitbucket::workspace/922e118c-f34f-4226-a897-0e0afbec553d"

  # subjects can be configured as explained at https://support.atlassian.com/bitbucket-cloud/docs/deploy-on-aws-using-bitbucket-pipelines-openid-connect/
  # {REPOSITORY_UUID}[:{ENVIRONMENT_UUID}]:{STEP_UUID}
  # E.g.
  # {1de489be-ce6a-42a0-a8c8-eadbf1174ac7}:{bd715740-c970-486b-b68a-b421ec2a1f8b}:{759de0c6-eaee-4eaa-b7a6-c507eec759a7}
  # {1de489be-ce6a-42a0-a8c8-eadbf1174ac7}:{759de0c6-eaee-4eaa-b7a6-c507eec759a7}

  subjects = [
    "{1de489be-ce6a-42a0-a8c8-eadbf1174ac7}:*",
    "{1de489be-ce6a-42a0-a8c8-eadbf1174ac7}:{bd715740-c970-486b-b68a-b421ec2a1f8b}:*",
  ]

  policies = {
    additional = aws_iam_policy.additional.arn
    S3ReadOnly = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  }

  tags = local.tags
}

module "iam_bitbucket_oidc_role_disabled" {
  source = "../../modules/iam-bitbucket-oidc-role"

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
