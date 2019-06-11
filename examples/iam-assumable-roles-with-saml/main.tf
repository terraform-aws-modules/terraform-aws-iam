provider "aws" {
  region = "eu-west-1"
}

resource "aws_iam_saml_provider" "idp_saml" {
  name                   = "idp_saml"
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

  provider_name = aws_iam_saml_provider.idp_saml.name
  provider_id   = aws_iam_saml_provider.idp_saml.id
}

#################################################################
# Create custom role with SAML idp trust and additional policies
#################################################################
module "iam_assumable_roles_with_saml_custom" {
  source = "../../modules/iam-assumable-roles-with-saml"

  create_poweruser_role      = true
  poweruser_role_name        = "Billing-And-Support-Access"
  poweruser_role_policy_arns = ["arn:aws:iam::aws:policy/job-function/Billing", "arn:aws:iam::aws:policy/AWSSupportAccess"]

  provider_name = aws_iam_saml_provider.idp_saml.name
  provider_id   = aws_iam_saml_provider.idp_saml.id
}
