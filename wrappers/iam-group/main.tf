module "wrapper" {
  source = "../../modules/iam-group"

  for_each = var.items

  create                             = try(each.value.create, var.defaults.create, true)
  create_policy                      = try(each.value.create_policy, var.defaults.create_policy, true)
  enable_mfa_enforcment              = try(each.value.enable_mfa_enforcment, var.defaults.enable_mfa_enforcment, true)
  enable_self_management_permissions = try(each.value.enable_self_management_permissions, var.defaults.enable_self_management_permissions, true)
  name                               = try(each.value.name, var.defaults.name, "")
  path                               = try(each.value.path, var.defaults.path, null)
  permission_statements              = try(each.value.permission_statements, var.defaults.permission_statements, [])
  policies                           = try(each.value.policies, var.defaults.policies, {})
  policy_description                 = try(each.value.policy_description, var.defaults.policy_description, null)
  policy_name_prefix                 = try(each.value.policy_name_prefix, var.defaults.policy_name_prefix, null)
  policy_path                        = try(each.value.policy_path, var.defaults.policy_path, null)
  tags                               = try(each.value.tags, var.defaults.tags, {})
  users                              = try(each.value.users, var.defaults.users, [])
  users_account_id                   = try(each.value.users_account_id, var.defaults.users_account_id, null)
}
