module "wrapper" {
  source = "../../modules/iam-github-oidc-role"

  for_each = var.items

  audience                 = try(each.value.audience, var.defaults.audience, "sts.amazonaws.com")
  create                   = try(each.value.create, var.defaults.create, true)
  description              = try(each.value.description, var.defaults.description, null)
  force_detach_policies    = try(each.value.force_detach_policies, var.defaults.force_detach_policies, true)
  max_session_duration     = try(each.value.max_session_duration, var.defaults.max_session_duration, null)
  name                     = try(each.value.name, var.defaults.name, null)
  name_prefix              = try(each.value.name_prefix, var.defaults.name_prefix, null)
  path                     = try(each.value.path, var.defaults.path, "/")
  permissions_boundary_arn = try(each.value.permissions_boundary_arn, var.defaults.permissions_boundary_arn, null)
  policies                 = try(each.value.policies, var.defaults.policies, {})
  provider_url             = try(each.value.provider_url, var.defaults.provider_url, "token.actions.githubusercontent.com")
  subjects                 = try(each.value.subjects, var.defaults.subjects, [])
  tags                     = try(each.value.tags, var.defaults.tags, {})
}
