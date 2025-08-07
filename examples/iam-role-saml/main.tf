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
# IAM Role w/ SAML
################################################################################

module "iam_role" {
  source = "../../modules/iam-role-saml"

  name = local.name

  saml_provider_ids = [aws_iam_saml_provider.this.id]

  policies = {
    ReadOnlyAccess = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  }

  tags = local.tags
}

module "iam_roles" {
  source = "../../modules/iam-role-saml"

  for_each = {
    admin = {
      policies = {
        AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
      }
    }
    readonly = {
      policies = {
        ReadOnlyAccess = "arn:aws:iam::aws:policy/ReadOnlyAccess"
      }
    }
    poweruser = {
      PowerUserAccess = "arn:aws:iam::aws:policy/PowerUserAccess"
    }
  }

  name_prefix = "${each.key}-"

  saml_provider_ids = [aws_iam_saml_provider.this.id]
  policies          = each.value.policies

  tags = local.tags
}

module "iam_role_disabled" {
  source = "../../modules/iam-role-oidc"

  create = false
}

################################################################################
# Supporting Resources
################################################################################

resource "aws_iam_saml_provider" "this" {
  name                   = "idp_saml"
  saml_metadata_document = file("saml-metadata.xml")
}
