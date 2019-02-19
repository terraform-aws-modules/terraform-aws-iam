provider "aws" {
  region = "eu-west-1"
}

#########################################
# IAM policy
#########################################
module "iam_policy" {
  source = "../../modules/iam-policy"

  name = "example"
  path = "/"
  description = "My example policy"

  policy ="./policy.tpl"
  }
