module "wrapper" {
  source = "../../modules/iam-group-with-assumable-roles-policy"

  for_each = var.items

  assumable_roles = try(each.value.assumable_roles, var.defaults.assumable_roles, [])
  group_users     = try(each.value.group_users, var.defaults.group_users, [])
  name            = try(each.value.name, var.defaults.name)
  path            = try(each.value.path, var.defaults.path, "/")
  tags            = try(each.value.tags, var.defaults.tags, {})
}
