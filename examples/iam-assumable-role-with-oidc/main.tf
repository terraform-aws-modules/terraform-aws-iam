provider "aws" {
  region = "eu-west-1"
}

###############################
# IAM assumable role for admin
###############################
module "iam_assumable_role_admin" {
  source = "../../modules/iam-assumable-role-with-oidc"

  create_role = true

  role_name = "role-with-oidc"

  tags = {
    Role = "role-with-oidc"
  }

  provider_url  = "oidc.eks.eu-west-1.amazonaws.com/id/BA9E170D464AF7B92084EF72A69B9DC8"
  provider_urls = ["oidc.eks.eu-west-1.amazonaws.com/id/AA9E170D464AF7B92084EF72A69B9DC8"]

  role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
  ]

  oidc_fully_qualified_subjects = ["system:serviceaccount:default:sa1", "system:serviceaccount:default:sa2"]
}
