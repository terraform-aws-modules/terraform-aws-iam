module "wrapper" {
  source = "../../modules/iam-role-saml"

  for_each = var.items

  assume_role_policy_statements = try(each.value.assume_role_policy_statements, var.defaults.assume_role_policy_statements, null)
  create                        = try(each.value.create, var.defaults.create, true)
  description                   = try(each.value.description, var.defaults.description, null)
  max_session_duration          = try(each.value.max_session_duration, var.defaults.max_session_duration, null)
  name                          = try(each.value.name, var.defaults.name, null)
  path                          = try(each.value.path, var.defaults.path, "/")
  permissions_boundary          = try(each.value.permissions_boundary, var.defaults.permissions_boundary, null)
  policies                      = try(each.value.policies, var.defaults.policies, {})
  saml_endpoints                = try(each.value.saml_endpoints, var.defaults.saml_endpoints, ["https://signin.aws.amazon.com/saml"])
  saml_provider_ids             = try(each.value.saml_provider_ids, var.defaults.saml_provider_ids, [])
  saml_trust_actions            = try(each.value.saml_trust_actions, var.defaults.saml_trust_actions, [])
  tags                          = try(each.value.tags, var.defaults.tags, {})
  use_name_prefix               = try(each.value.use_name_prefix, var.defaults.use_name_prefix, true)
}
