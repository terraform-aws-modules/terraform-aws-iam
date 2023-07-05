provider "aws" {
  region = "eu-west-1"
}

##############
# IAM account
##############
module "iam_account" {
  source = "../../modules/iam-account"

  account_alias = "new-test-account-awesome-company"

  minimum_password_length = 6
  require_numbers         = false
}

module "iam_account_no_alias" {
  source = "../../modules/iam-account"

  account_alias        = ""
  create_account_alias = false

  minimum_password_length = 6
  require_numbers         = false
}
