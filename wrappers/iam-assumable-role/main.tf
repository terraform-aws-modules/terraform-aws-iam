module "wrapper" {
  source = "../../modules/iam-assumable-role"

  for_each = var.items

  trusted_role_actions              = try(each.value.trusted_role_actions, var.defaults.trusted_role_actions, ["sts:AssumeRole", "sts:TagSession"])
  trusted_role_arns                 = try(each.value.trusted_role_arns, var.defaults.trusted_role_arns, [])
  trusted_role_services             = try(each.value.trusted_role_services, var.defaults.trusted_role_services, [])
  mfa_age                           = try(each.value.mfa_age, var.defaults.mfa_age, 86400)
  max_session_duration              = try(each.value.max_session_duration, var.defaults.max_session_duration, 3600)
  create_role                       = try(each.value.create_role, var.defaults.create_role, false)
  create_instance_profile           = try(each.value.create_instance_profile, var.defaults.create_instance_profile, false)
  role_name                         = try(each.value.role_name, var.defaults.role_name, null)
  role_name_prefix                  = try(each.value.role_name_prefix, var.defaults.role_name_prefix, null)
  role_path                         = try(each.value.role_path, var.defaults.role_path, "/")
  role_requires_mfa                 = try(each.value.role_requires_mfa, var.defaults.role_requires_mfa, true)
  role_permissions_boundary_arn     = try(each.value.role_permissions_boundary_arn, var.defaults.role_permissions_boundary_arn, "")
  tags                              = try(each.value.tags, var.defaults.tags, {})
  custom_role_policy_arns           = try(each.value.custom_role_policy_arns, var.defaults.custom_role_policy_arns, [])
  custom_role_trust_policy          = try(each.value.custom_role_trust_policy, var.defaults.custom_role_trust_policy, "")
  number_of_custom_role_policy_arns = try(each.value.number_of_custom_role_policy_arns, var.defaults.number_of_custom_role_policy_arns, null)
  admin_role_policy_arn             = try(each.value.admin_role_policy_arn, var.defaults.admin_role_policy_arn, "arn:aws:iam::aws:policy/AdministratorAccess")
  poweruser_role_policy_arn         = try(each.value.poweruser_role_policy_arn, var.defaults.poweruser_role_policy_arn, "arn:aws:iam::aws:policy/PowerUserAccess")
  readonly_role_policy_arn          = try(each.value.readonly_role_policy_arn, var.defaults.readonly_role_policy_arn, "arn:aws:iam::aws:policy/ReadOnlyAccess")
  attach_admin_policy               = try(each.value.attach_admin_policy, var.defaults.attach_admin_policy, false)
  attach_poweruser_policy           = try(each.value.attach_poweruser_policy, var.defaults.attach_poweruser_policy, false)
  attach_readonly_policy            = try(each.value.attach_readonly_policy, var.defaults.attach_readonly_policy, false)
  force_detach_policies             = try(each.value.force_detach_policies, var.defaults.force_detach_policies, false)
  role_description                  = try(each.value.role_description, var.defaults.role_description, "")
  role_sts_externalid               = try(each.value.role_sts_externalid, var.defaults.role_sts_externalid, [])
  allow_self_assume_role            = try(each.value.allow_self_assume_role, var.defaults.allow_self_assume_role, false)
  role_requires_session_name        = try(each.value.role_requires_session_name, var.defaults.role_requires_session_name, false)
  role_session_name                 = try(each.value.role_session_name, var.defaults.role_session_name, ["$${aws:username}"])
}
