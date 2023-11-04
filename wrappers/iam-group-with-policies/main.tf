module "wrapper" {
  source = "../../modules/iam-group-with-policies"

  for_each = var.items

  attach_iam_self_management_policy      = try(each.value.attach_iam_self_management_policy, var.defaults.attach_iam_self_management_policy, true)
  aws_account_id                         = try(each.value.aws_account_id, var.defaults.aws_account_id, "")
  create_group                           = try(each.value.create_group, var.defaults.create_group, true)
  custom_group_policies                  = try(each.value.custom_group_policies, var.defaults.custom_group_policies, [])
  custom_group_policy_arns               = try(each.value.custom_group_policy_arns, var.defaults.custom_group_policy_arns, [])
  enable_mfa_enforcement                 = try(each.value.enable_mfa_enforcement, var.defaults.enable_mfa_enforcement, true)
  group_users                            = try(each.value.group_users, var.defaults.group_users, [])
  iam_self_management_policy_name_prefix = try(each.value.iam_self_management_policy_name_prefix, var.defaults.iam_self_management_policy_name_prefix, "IAMSelfManagement-")
  name                                   = try(each.value.name, var.defaults.name, "")
  path                                   = try(each.value.path, var.defaults.path, "/")
  tags                                   = try(each.value.tags, var.defaults.tags, {})
}
