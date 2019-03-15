provider "aws" {
  region = "eu-west-1"
}

resource "aws_iam_saml_provider" "idp_saml" {
  name                   = "idp_saml"
  saml_metadata_document = "${file("${path.module}/saml-metadata.xml")}"
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
