module "wrapper" {
  source = "../../modules/iam-github-oidc-provider"

  for_each = var.items

  create                 = try(each.value.create, var.defaults.create, true)
  tags                   = try(each.value.tags, var.defaults.tags, {})
  client_id_list         = try(each.value.client_id_list, var.defaults.client_id_list, [])
  url                    = try(each.value.url, var.defaults.url, "https://token.actions.githubusercontent.com")
  additional_thumbprints = try(each.value.additional_thumbprints, var.defaults.additional_thumbprints, [])
}
