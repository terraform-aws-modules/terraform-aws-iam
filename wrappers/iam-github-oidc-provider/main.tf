module "wrapper" {
  source = "../../modules/iam-github-oidc-provider"

  for_each = var.items

  additional_thumbprints = try(each.value.additional_thumbprints, var.defaults.additional_thumbprints, [
    "6938fd4d98bab03faadb97b34396831e3780aea1",
    "1c58a3a8518e8759bf075b76b750d4f2df264fcd"
  ])
  client_id_list = try(each.value.client_id_list, var.defaults.client_id_list, [])
  create         = try(each.value.create, var.defaults.create, true)
  tags           = try(each.value.tags, var.defaults.tags, {})
  url            = try(each.value.url, var.defaults.url, "https://token.actions.githubusercontent.com")
}
