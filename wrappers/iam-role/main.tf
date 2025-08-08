module "wrapper" {
  source = "../../modules/iam-role"

  for_each = var.items

  assume_role_policy_statements = try(each.value.assume_role_policy_statements, var.defaults.assume_role_policy_statements, null)
  condition                     = try(each.value.condition, var.defaults.condition, [])
  create                        = try(each.value.create, var.defaults.create, true)
  create_instance_profile       = try(each.value.create_instance_profile, var.defaults.create_instance_profile, false)
  description                   = try(each.value.description, var.defaults.description, null)
  enable_bitbucket_oidc         = try(each.value.enable_bitbucket_oidc, var.defaults.enable_bitbucket_oidc, false)
  enable_github_oidc            = try(each.value.enable_github_oidc, var.defaults.enable_github_oidc, false)
  enable_oidc                   = try(each.value.enable_oidc, var.defaults.enable_oidc, false)
  enable_saml                   = try(each.value.enable_saml, var.defaults.enable_saml, false)
  github_provider               = try(each.value.github_provider, var.defaults.github_provider, "token.actions.githubusercontent.com")
  inline_policy_statements      = try(each.value.inline_policy_statements, var.defaults.inline_policy_statements, null)
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
  saml_endpoints                = try(each.value.saml_endpoints, var.defaults.saml_endpoints, ["https://signin.aws.amazon.com/saml"])
  saml_provider_ids             = try(each.value.saml_provider_ids, var.defaults.saml_provider_ids, [])
  saml_trust_actions            = try(each.value.saml_trust_actions, var.defaults.saml_trust_actions, [])
  tags                          = try(each.value.tags, var.defaults.tags, {})
  use_name_prefix               = try(each.value.use_name_prefix, var.defaults.use_name_prefix, true)
}
