module "wrapper" {
  source = "../../modules/iam-assumable-roles"

  for_each = var.items

  admin_role_name                         = try(each.value.admin_role_name, var.defaults.admin_role_name, "admin")
  admin_role_path                         = try(each.value.admin_role_path, var.defaults.admin_role_path, "/")
  admin_role_permissions_boundary_arn     = try(each.value.admin_role_permissions_boundary_arn, var.defaults.admin_role_permissions_boundary_arn, "")
  admin_role_policy_arns                  = try(each.value.admin_role_policy_arns, var.defaults.admin_role_policy_arns, ["arn:aws:iam::aws:policy/AdministratorAccess"])
  admin_role_requires_mfa                 = try(each.value.admin_role_requires_mfa, var.defaults.admin_role_requires_mfa, true)
  admin_role_tags                         = try(each.value.admin_role_tags, var.defaults.admin_role_tags, {})
  allow_self_assume_role                  = try(each.value.allow_self_assume_role, var.defaults.allow_self_assume_role, false)
  create_admin_role                       = try(each.value.create_admin_role, var.defaults.create_admin_role, false)
  create_poweruser_role                   = try(each.value.create_poweruser_role, var.defaults.create_poweruser_role, false)
  create_readonly_role                    = try(each.value.create_readonly_role, var.defaults.create_readonly_role, false)
  force_detach_policies                   = try(each.value.force_detach_policies, var.defaults.force_detach_policies, false)
  max_session_duration                    = try(each.value.max_session_duration, var.defaults.max_session_duration, 3600)
  mfa_age                                 = try(each.value.mfa_age, var.defaults.mfa_age, 86400)
  poweruser_role_name                     = try(each.value.poweruser_role_name, var.defaults.poweruser_role_name, "poweruser")
  poweruser_role_path                     = try(each.value.poweruser_role_path, var.defaults.poweruser_role_path, "/")
  poweruser_role_permissions_boundary_arn = try(each.value.poweruser_role_permissions_boundary_arn, var.defaults.poweruser_role_permissions_boundary_arn, "")
  poweruser_role_policy_arns              = try(each.value.poweruser_role_policy_arns, var.defaults.poweruser_role_policy_arns, ["arn:aws:iam::aws:policy/PowerUserAccess"])
  poweruser_role_requires_mfa             = try(each.value.poweruser_role_requires_mfa, var.defaults.poweruser_role_requires_mfa, true)
  poweruser_role_tags                     = try(each.value.poweruser_role_tags, var.defaults.poweruser_role_tags, {})
  readonly_role_name                      = try(each.value.readonly_role_name, var.defaults.readonly_role_name, "readonly")
  readonly_role_path                      = try(each.value.readonly_role_path, var.defaults.readonly_role_path, "/")
  readonly_role_permissions_boundary_arn  = try(each.value.readonly_role_permissions_boundary_arn, var.defaults.readonly_role_permissions_boundary_arn, "")
  readonly_role_policy_arns               = try(each.value.readonly_role_policy_arns, var.defaults.readonly_role_policy_arns, ["arn:aws:iam::aws:policy/ReadOnlyAccess"])
  readonly_role_requires_mfa              = try(each.value.readonly_role_requires_mfa, var.defaults.readonly_role_requires_mfa, true)
  readonly_role_tags                      = try(each.value.readonly_role_tags, var.defaults.readonly_role_tags, {})
  trusted_role_actions                    = try(each.value.trusted_role_actions, var.defaults.trusted_role_actions, ["sts:AssumeRole", "sts:TagSession"])
  trusted_role_arns                       = try(each.value.trusted_role_arns, var.defaults.trusted_role_arns, [])
  trusted_role_services                   = try(each.value.trusted_role_services, var.defaults.trusted_role_services, [])
}
