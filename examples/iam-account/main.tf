provider "aws" {
  region = "eu-west-1"
}

##############
# IAM account
##############
module "iam_account" {
  source = "../../modules/iam-account"

  account_alias = "test-account-awesome-company"

  minimum_password_length = 6
  require_numbers         = false
}
