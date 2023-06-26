module "wrapper" {
  source = "../../modules/iam-assumable-role-with-oidc"

  for_each = var.items

  create_role                    = try(each.value.create_role, var.defaults.create_role, false)
  provider_url                   = try(each.value.provider_url, var.defaults.provider_url, "")
  provider_urls                  = try(each.value.provider_urls, var.defaults.provider_urls, [])
  aws_account_id                 = try(each.value.aws_account_id, var.defaults.aws_account_id, "")
  tags                           = try(each.value.tags, var.defaults.tags, {})
  role_name                      = try(each.value.role_name, var.defaults.role_name, null)
  role_name_prefix               = try(each.value.role_name_prefix, var.defaults.role_name_prefix, null)
  role_description               = try(each.value.role_description, var.defaults.role_description, "")
  role_path                      = try(each.value.role_path, var.defaults.role_path, "/")
  role_permissions_boundary_arn  = try(each.value.role_permissions_boundary_arn, var.defaults.role_permissions_boundary_arn, "")
  max_session_duration           = try(each.value.max_session_duration, var.defaults.max_session_duration, 3600)
  role_policy_arns               = try(each.value.role_policy_arns, var.defaults.role_policy_arns, [])
  number_of_role_policy_arns     = try(each.value.number_of_role_policy_arns, var.defaults.number_of_role_policy_arns, null)
  oidc_fully_qualified_subjects  = try(each.value.oidc_fully_qualified_subjects, var.defaults.oidc_fully_qualified_subjects, [])
  oidc_subjects_with_wildcards   = try(each.value.oidc_subjects_with_wildcards, var.defaults.oidc_subjects_with_wildcards, [])
  oidc_fully_qualified_audiences = try(each.value.oidc_fully_qualified_audiences, var.defaults.oidc_fully_qualified_audiences, [])
  force_detach_policies          = try(each.value.force_detach_policies, var.defaults.force_detach_policies, false)
  allow_self_assume_role         = try(each.value.allow_self_assume_role, var.defaults.allow_self_assume_role, false)
}
