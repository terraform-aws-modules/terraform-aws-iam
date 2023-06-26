module "wrapper" {
  source = "../../modules/iam-account"

  for_each = var.items

  get_caller_identity            = try(each.value.get_caller_identity, var.defaults.get_caller_identity, true)
  account_alias                  = try(each.value.account_alias, var.defaults.account_alias)
  create_account_password_policy = try(each.value.create_account_password_policy, var.defaults.create_account_password_policy, true)
  max_password_age               = try(each.value.max_password_age, var.defaults.max_password_age, 0)
  minimum_password_length        = try(each.value.minimum_password_length, var.defaults.minimum_password_length, 8)
  allow_users_to_change_password = try(each.value.allow_users_to_change_password, var.defaults.allow_users_to_change_password, true)
  hard_expiry                    = try(each.value.hard_expiry, var.defaults.hard_expiry, false)
  password_reuse_prevention      = try(each.value.password_reuse_prevention, var.defaults.password_reuse_prevention, null)
  require_lowercase_characters   = try(each.value.require_lowercase_characters, var.defaults.require_lowercase_characters, true)
  require_uppercase_characters   = try(each.value.require_uppercase_characters, var.defaults.require_uppercase_characters, true)
  require_numbers                = try(each.value.require_numbers, var.defaults.require_numbers, true)
  require_symbols                = try(each.value.require_symbols, var.defaults.require_symbols, true)
}
