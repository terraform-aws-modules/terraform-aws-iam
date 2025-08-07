module "wrapper" {
  source = "../../modules/iam-oidc-provider"

  for_each = var.items

  client_id_list = try(each.value.client_id_list, var.defaults.client_id_list, [])
  create         = try(each.value.create, var.defaults.create, true)
  tags           = try(each.value.tags, var.defaults.tags, {})
  url            = try(each.value.url, var.defaults.url, "https://token.actions.githubusercontent.com")
}
