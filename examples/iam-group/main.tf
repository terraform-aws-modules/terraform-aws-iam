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
# IAM Group
################################################################################

module "iam_group" {
  source = "../../modules/iam-group"

  name = "production-admins"

  users = [
    module.iam_user1.name,
    module.iam_user2.name,
  ]

  permissions = {
    AssumeRole = {
      actions   = ["sts:AssumeRole"]
      resources = ["arn:aws:iam::111111111111:role/admin"]
    }
  }

  policies = {
    ReadOnlyAccess = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  }

  tags = local.tags
}

module "iam_group_disabled" {
  source = "../../modules/iam-group"

  create = false
}

################################################################################
# Supporting resources
################################################################################

module "iam_user1" {
  source = "../../modules/iam-user"

  name = "${local.name}-user1"

  create_login_profile = false
  create_access_key    = false

  tags = local.tags
}

module "iam_user2" {
  source = "../../modules/iam-user"

  name = "${local.name}-user2"

  create_login_profile = false
  create_access_key    = false

  tags = local.tags
}

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
