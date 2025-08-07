module "wrapper" {
  source = "../../modules/iam-role-oidc"

  for_each = var.items

  assume_role_policy_statements = try(each.value.assume_role_policy_statements, var.defaults.assume_role_policy_statements, null)
  create                        = try(each.value.create, var.defaults.create, true)
  description                   = try(each.value.description, var.defaults.description, null)
  enable_bitbucket_oidc         = try(each.value.enable_bitbucket_oidc, var.defaults.enable_bitbucket_oidc, false)
  enable_github_oidc            = try(each.value.enable_github_oidc, var.defaults.enable_github_oidc, false)
  max_session_duration          = try(each.value.max_session_duration, var.defaults.max_session_duration, null)
  name                          = try(each.value.name, var.defaults.name, null)
  oidc_account_id               = try(each.value.oidc_account_id, var.defaults.oidc_account_id, null)
  oidc_audiences                = try(each.value.oidc_audiences, var.defaults.oidc_audiences, [])
  oidc_provider_urls            = try(each.value.oidc_provider_urls, var.defaults.oidc_provider_urls, [])
  oidc_subjects                 = try(each.value.oidc_subjects, var.defaults.oidc_subjects, [])
  oidc_wildcard_subjects        = try(each.value.oidc_wildcard_subjects, var.defaults.oidc_wildcard_subjects, [])
  path                          = try(each.value.path, var.defaults.path, "/")
  permissions_boundary          = try(each.value.permissions_boundary, var.defaults.permissions_boundary, null)
  policies                      = try(each.value.policies, var.defaults.policies, {})
  tags                          = try(each.value.tags, var.defaults.tags, {})
  use_name_prefix               = try(each.value.use_name_prefix, var.defaults.use_name_prefix, true)
}
