module "wrapper" {
  source = "../../modules/iam-circleci-oidc-provider"

  for_each = var.items

  base_url    = try(each.value.base_url, var.defaults.base_url, "https://oidc.circleci.com/org")
  create      = try(each.value.create, var.defaults.create, true)
  org_uuid    = try(each.value.org_uuid, var.defaults.org_uuid)
  tags        = try(each.value.tags, var.defaults.tags, {})
  thumbprints = try(each.value.thumbprints, var.defaults.thumbprints, ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"])
}
