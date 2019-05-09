provider "aws" {
  region = "eu-west-1"
}

resource "aws_iam_saml_provider" "idp_saml" {
  name                   = "idp_saml"
  saml_metadata_document = "${file("saml-metadata.xml")}"
}

###############################
# IAM assumable roles with SAML
###############################

module "iam_assumable_roles_with_saml" {
  source = "../../../terraform-aws-iam/modules/iam-assumable-roles-with-saml"

  create_admin_role = true

  create_poweruser_role = true
  poweruser_role_name   = "developer"

  create_readonly_role = true

  provider_name = "${aws_iam_saml_provider.idp_saml.name}"
  provider_id   = "${aws_iam_saml_provider.idp_saml.id}"
}

#################################################################
# Create custom role with SAML idp trust and additional policies
#################################################################
module "iam_assumable_roles_with_saml_custom" {
  source = "../../../terraform-aws-iam/modules/iam-assumable-roles-with-saml"

  create_poweruser_role = true

  create_poweruser_role                  = true
  poweruser_role_name                    = "Billing-And-Support-Access"
  poweruser_role_policy_arn              = "arn:aws:iam::aws:policy/job-function/Billing"
  poweruser_role_additional_policies_arn = ["arn:aws:iam::aws:policy/AWSSupportAccess"]

  create_readonly_role = true

  provider_name = "${aws_iam_saml_provider.idp_saml.name}"
  provider_id   = "${aws_iam_saml_provider.idp_saml.id}"
}
