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

#####################################
# IAM assumable role with self assume
#####################################
module "iam_assumable_role_self_assume" {
  source = "../../modules/iam-assumable-role-with-saml"

  create_role            = true
  allow_self_assume_role = true

  role_name = "role-with-saml-self-assume"

  tags = {
    Role = "role-with-saml-self-assume"
  }

  provider_id  = aws_iam_saml_provider.idp_saml.id
  provider_ids = [aws_iam_saml_provider.second_idp_saml.id]

  role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
  ]
}

#####################################
# IAM assumable role with custom trust policy
#####################################
module "iam_assumable_role_custom_trust_policy" {
  source = "../../modules/iam-assumable-role-with-saml"

  create_role                     = true
  create_custom_role_trust_policy = true
  custom_role_trust_policy        = data.aws_iam_policy_document.custom_trust_policy.json

  role_name = "role-with-saml-custom-trust"

  tags = {
    Role = "role-with-saml-custom-trust"
  }

  provider_id  = aws_iam_saml_provider.idp_saml.id
  provider_ids = [aws_iam_saml_provider.second_idp_saml.id]

  role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
  ]
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
