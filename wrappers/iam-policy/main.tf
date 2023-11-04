module "wrapper" {
  source = "../../modules/iam-policy"

  for_each = var.items

  create_policy = try(each.value.create_policy, var.defaults.create_policy, true)
  description   = try(each.value.description, var.defaults.description, "IAM Policy")
  name          = try(each.value.name, var.defaults.name, null)
  name_prefix   = try(each.value.name_prefix, var.defaults.name_prefix, null)
  path          = try(each.value.path, var.defaults.path, "/")
  policy        = try(each.value.policy, var.defaults.policy, "")
  tags          = try(each.value.tags, var.defaults.tags, {})
}
