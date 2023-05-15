provider "aws" {
  region = "eu-west-1"
}

resource "aws_iam_saml_provider" "idp_saml" {
  name                   = "idp_saml"
  saml_metadata_document = file("saml-metadata.xml")
}

resource "aws_iam_saml_provider" "second_idp_saml" {
  name                   = "second_idp_saml"
  saml_metadata_document = file("saml-metadata.xml")
}

###############################
# IAM assumable roles with SAML
###############################

module "iam_assumable_roles_with_saml" {
  source = "../../modules/iam-assumable-roles-with-saml"

  # create_admin_role = true

  create_poweruser_role = true
  poweruser_role_name   = "developer"

  create_readonly_role = true

  provider_id = aws_iam_saml_provider.idp_saml.id
}

###############################
# IAM assumable roles with SAML
###############################

module "iam_assumable_roles_with_saml_second_provider" {
  source = "../../modules/iam-assumable-roles-with-saml"

  create_admin_role = true

  create_poweruser_role = true
  admin_role_name       = "Admin-Role-Name"
  poweruser_role_name   = "Poweruser-Role-Name"
  readonly_role_name    = "Readonly-Role-Name"

  create_readonly_role = true

  provider_ids = [aws_iam_saml_provider.idp_saml.id, aws_iam_saml_provider.second_idp_saml.id]
}

#################################################################
# Create custom role with SAML idp trust and additional policies
#################################################################
module "iam_assumable_roles_with_saml_custom" {
  source = "../../modules/iam-assumable-roles-with-saml"

  create_poweruser_role      = true
  poweruser_role_name        = "Billing-And-Support-Access"
  poweruser_role_policy_arns = ["arn:aws:iam::aws:policy/job-function/Billing", "arn:aws:iam::aws:policy/AWSSupportAccess"]

  provider_id = aws_iam_saml_provider.idp_saml.id
}

################################################
# IAM assumable roles with SAML with self assume
################################################
module "iam_assumable_roles_with_saml_with_self_assume" {
  source = "../../modules/iam-assumable-roles-with-saml"

  create_admin_role      = true
  allow_self_assume_role = true
  create_poweruser_role  = true
  admin_role_name        = "Admin-Role-Name-Self-Assume"
  poweruser_role_name    = "Poweruser-Role-Name-Self-Assume"
  readonly_role_name     = "Readonly-Role-Name-Self-Assume"
  create_readonly_role   = true

  provider_id = aws_iam_saml_provider.idp_saml.id
}

################################################
# IAM assumable roles with SAML with custom trust
################################################
module "iam_assumable_roles_with_saml_with_custom_trust" {
  source = "../../modules/iam-assumable-roles-with-saml"

  create_admin_role               = true
  create_custom_role_trust_policy = true
  custom_role_trust_policy        = data.aws_iam_policy_document.custom_trust_policy.json
  create_poweruser_role           = true
  admin_role_name                 = "Admin-Role-Name-Custom-Trust"
  poweruser_role_name             = "Poweruser-Role-Name-Custom-Trust"
  readonly_role_name              = "Readonly-Role-Name-Custom-Trust"
  create_readonly_role            = true

  provider_id = aws_iam_saml_provider.idp_saml.id
}

data "aws_iam_policy_document" "custom_trust_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithSAML"]

    principals {
      type = "Federated"
      identifiers = [
        aws_iam_saml_provider.idp_saml.id
      ]
    }
    condition {
      test     = "StringEquals"
      variable = "SAML:aud"
      values = [
        "https://signin.aws.amazon.com/saml"
      ]
    }
  }
  statement {
    effect  = "Allow"
    actions = ["sts:TagSession"]

    principals {
      type = "Federated"
      identifiers = [
        aws_iam_saml_provider.idp_saml.id
      ]
    }
    condition {
      test     = "StringLike"
      variable = "aws:RequestTag/groups"
      values   = ["*"]
    }
  }
}
