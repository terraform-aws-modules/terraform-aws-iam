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

  create_admin_role = true

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

###########################################################################
# IAM assumable roles with SAML with dedicated max session duration per role
###########################################################################
module "iam_assumable_roles_with_saml_with_dedicated_max_session_duration" {
  source = "../../modules/iam-assumable-roles-with-saml"

  create_admin_role          = true
  admin_role_name            = "Admin-Role-Custom-Max-Session-Duration"
  admin_max_session_duration = 7200

  create_poweruser_role          = true
  poweruser_role_name            = "Poweruser-Role-Custom-Max-Session-Duration"
  poweruser_max_session_duration = 14400

  create_readonly_role          = true
  readonly_role_name            = "Readonly-Role-Custom-Max-Session-Duration"
  readonly_max_session_duration = 43200

  provider_id = aws_iam_saml_provider.idp_saml.id
}
