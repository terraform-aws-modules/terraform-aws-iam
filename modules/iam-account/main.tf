data "aws_caller_identity" "this" {
  count = var.get_caller_identity ? 1 : 0
}

resource "aws_iam_account_alias" "this" {
  account_alias = var.account_alias
}

resource "aws_iam_account_password_policy" "this" {
  count = var.create_account_password_policy ? 1 : 0

  max_password_age               = var.max_password_age
  minimum_password_length        = var.minimum_password_length
  allow_users_to_change_password = var.allow_users_to_change_password
  hard_expiry                    = var.hard_expiry
  password_reuse_prevention      = var.password_reuse_prevention
  require_lowercase_characters   = var.require_lowercase_characters
  require_uppercase_characters   = var.require_uppercase_characters
  require_numbers                = var.require_numbers
  require_symbols                = var.require_symbols
}
