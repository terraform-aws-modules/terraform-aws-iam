module "wrapper" {
  source = "../../modules/iam-circleci-oidc-role"

  for_each = var.items

  base_url                 = try(each.value.base_url, var.defaults.base_url, "https://oidc.circleci.com/org")
  create                   = try(each.value.create, var.defaults.create, true)
  description              = try(each.value.description, var.defaults.description, null)
  force_detach_policies    = try(each.value.force_detach_policies, var.defaults.force_detach_policies, true)
  max_session_duration     = try(each.value.max_session_duration, var.defaults.max_session_duration, null)
  name                     = try(each.value.name, var.defaults.name, null)
  name_prefix              = try(each.value.name_prefix, var.defaults.name_prefix, null)
  oidc_provider_arn        = try(each.value.oidc_provider_arn, var.defaults.oidc_provider_arn)
  org_uuid                 = try(each.value.org_uuid, var.defaults.org_uuid)
  path                     = try(each.value.path, var.defaults.path, "/")
  permissions_boundary_arn = try(each.value.permissions_boundary_arn, var.defaults.permissions_boundary_arn, null)
  policies                 = try(each.value.policies, var.defaults.policies, {})
  project_uuids            = try(each.value.project_uuids, var.defaults.project_uuids, [])
  tags                     = try(each.value.tags, var.defaults.tags, {})
}
