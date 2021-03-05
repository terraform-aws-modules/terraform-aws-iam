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
# IAM assumable role for admin
###############################
module "iam_assumable_role_admin" {
  source = "../../modules/iam-assumable-role-with-saml"

  create_role = true

  role_name = "role-with-saml"

  tags = {
    Role = "role-with-saml"
  }

  provider_id  = aws_iam_saml_provider.idp_saml.id
  provider_ids = [aws_iam_saml_provider.second_idp_saml.id]

  role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
  ]
}
