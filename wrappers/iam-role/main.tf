module "wrapper" {
  source = "../../modules/iam-role"

  for_each = var.items

  allow_self_assume_role        = try(each.value.allow_self_assume_role, var.defaults.allow_self_assume_role, false)
  assume_role_policy_statements = try(each.value.assume_role_policy_statements, var.defaults.assume_role_policy_statements, [])
  create                        = try(each.value.create, var.defaults.create, true)
  create_instance_profile       = try(each.value.create_instance_profile, var.defaults.create_instance_profile, false)
  description                   = try(each.value.description, var.defaults.description, null)
  max_session_duration          = try(each.value.max_session_duration, var.defaults.max_session_duration, null)
  name                          = try(each.value.name, var.defaults.name, null)
  name_prefix                   = try(each.value.name_prefix, var.defaults.name_prefix, null)
  path                          = try(each.value.path, var.defaults.path, "/")
  permissions_boundary          = try(each.value.permissions_boundary, var.defaults.permissions_boundary, null)
  policies                      = try(each.value.policies, var.defaults.policies, {})
  tags                          = try(each.value.tags, var.defaults.tags, {})
}
