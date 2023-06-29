module "wrapper" {
  source = "../../modules/iam-assumable-role-with-saml"

  for_each = var.items

  create_role                   = try(each.value.create_role, var.defaults.create_role, false)
  provider_id                   = try(each.value.provider_id, var.defaults.provider_id, "")
  provider_ids                  = try(each.value.provider_ids, var.defaults.provider_ids, [])
  aws_saml_endpoint             = try(each.value.aws_saml_endpoint, var.defaults.aws_saml_endpoint, "https://signin.aws.amazon.com/saml")
  tags                          = try(each.value.tags, var.defaults.tags, {})
  role_name                     = try(each.value.role_name, var.defaults.role_name, null)
  role_name_prefix              = try(each.value.role_name_prefix, var.defaults.role_name_prefix, null)
  role_description              = try(each.value.role_description, var.defaults.role_description, "")
  role_path                     = try(each.value.role_path, var.defaults.role_path, "/")
  role_permissions_boundary_arn = try(each.value.role_permissions_boundary_arn, var.defaults.role_permissions_boundary_arn, "")
  max_session_duration          = try(each.value.max_session_duration, var.defaults.max_session_duration, 3600)
  role_policy_arns              = try(each.value.role_policy_arns, var.defaults.role_policy_arns, [])
  number_of_role_policy_arns    = try(each.value.number_of_role_policy_arns, var.defaults.number_of_role_policy_arns, null)
  force_detach_policies         = try(each.value.force_detach_policies, var.defaults.force_detach_policies, false)
  allow_self_assume_role        = try(each.value.allow_self_assume_role, var.defaults.allow_self_assume_role, false)
  trusted_role_actions          = try(each.value.trusted_role_actions, var.defaults.trusted_role_actions, ["sts:AssumeRoleWithSAML", "sts:TagSession"])
}
