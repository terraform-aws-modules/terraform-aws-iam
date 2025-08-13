module "wrapper" {
  source = "../../modules/iam-policy"

  for_each = var.items

  create      = try(each.value.create, var.defaults.create, true)
  description = try(each.value.description, var.defaults.description, null)
  name        = try(each.value.name, var.defaults.name, null)
  name_prefix = try(each.value.name_prefix, var.defaults.name_prefix, null)
  path        = try(each.value.path, var.defaults.path, null)
  policy      = try(each.value.policy, var.defaults.policy, "")
  tags        = try(each.value.tags, var.defaults.tags, {})
}
