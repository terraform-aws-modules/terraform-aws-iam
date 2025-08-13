module "wrapper" {
  source = "../../modules/iam-read-only-policy"

  for_each = var.items

  allow_cloudwatch_logs_query      = try(each.value.allow_cloudwatch_logs_query, var.defaults.allow_cloudwatch_logs_query, true)
  allow_predefined_sts_actions     = try(each.value.allow_predefined_sts_actions, var.defaults.allow_predefined_sts_actions, true)
  allow_web_console_services       = try(each.value.allow_web_console_services, var.defaults.allow_web_console_services, true)
  allowed_services                 = try(each.value.allowed_services, var.defaults.allowed_services, [])
  create                           = try(each.value.create, var.defaults.create, true)
  create_policy                    = try(each.value.create_policy, var.defaults.create_policy, true)
  description                      = try(each.value.description, var.defaults.description, null)
  name                             = try(each.value.name, var.defaults.name, null)
  override_inline_policy_documents = try(each.value.override_inline_policy_documents, var.defaults.override_inline_policy_documents, [])
  path                             = try(each.value.path, var.defaults.path, null)
  source_inline_policy_documents   = try(each.value.source_inline_policy_documents, var.defaults.source_inline_policy_documents, [])
  tags                             = try(each.value.tags, var.defaults.tags, {})
  use_name_prefix                  = try(each.value.use_name_prefix, var.defaults.use_name_prefix, true)
  web_console_services             = try(each.value.web_console_services, var.defaults.web_console_services, ["resource-groups", "tag", "health", "ce"])
}
