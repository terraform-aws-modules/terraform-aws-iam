provider "aws" {
  region = "eu-west-1"
}

#########################################
# IAM user, login profile and access key
#########################################
module "iam_user" {
  source = "../../modules/iam-user"

  name          = "vasya.pupkin"
  force_destroy = true

  # User "test" has uploaded his public key here - https://keybase.io/test/pgp_keys.asc
  pgp_key = "keybase:test"

  password_reset_required = false
}
