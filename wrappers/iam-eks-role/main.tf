module "wrapper" {
  source = "../../modules/iam-eks-role"

  for_each = var.items

  create_role                   = try(each.value.create_role, var.defaults.create_role, true)
  role_name                     = try(each.value.role_name, var.defaults.role_name, null)
  role_path                     = try(each.value.role_path, var.defaults.role_path, "/")
  role_permissions_boundary_arn = try(each.value.role_permissions_boundary_arn, var.defaults.role_permissions_boundary_arn, "")
  role_description              = try(each.value.role_description, var.defaults.role_description, "")
  role_name_prefix              = try(each.value.role_name_prefix, var.defaults.role_name_prefix, null)
  role_policy_arns              = try(each.value.role_policy_arns, var.defaults.role_policy_arns, {})
  cluster_service_accounts      = try(each.value.cluster_service_accounts, var.defaults.cluster_service_accounts, {})
  tags                          = try(each.value.tags, var.defaults.tags, {})
  force_detach_policies         = try(each.value.force_detach_policies, var.defaults.force_detach_policies, false)
  max_session_duration          = try(each.value.max_session_duration, var.defaults.max_session_duration, 43200)
  allow_self_assume_role        = try(each.value.allow_self_assume_role, var.defaults.allow_self_assume_role, false)
  assume_role_condition_test    = try(each.value.assume_role_condition_test, var.defaults.assume_role_condition_test, "StringEquals")
}
