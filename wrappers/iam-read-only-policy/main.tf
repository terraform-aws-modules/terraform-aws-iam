module "wrapper" {
  source = "../../modules/iam-read-only-policy"

  for_each = var.items

  additional_policy_json       = try(each.value.additional_policy_json, var.defaults.additional_policy_json, "{}")
  allow_cloudwatch_logs_query  = try(each.value.allow_cloudwatch_logs_query, var.defaults.allow_cloudwatch_logs_query, true)
  allow_predefined_sts_actions = try(each.value.allow_predefined_sts_actions, var.defaults.allow_predefined_sts_actions, true)
  allow_web_console_services   = try(each.value.allow_web_console_services, var.defaults.allow_web_console_services, true)
  allowed_services             = try(each.value.allowed_services, var.defaults.allowed_services)
  create_policy                = try(each.value.create_policy, var.defaults.create_policy, true)
  description                  = try(each.value.description, var.defaults.description, "IAM Policy")
  name                         = try(each.value.name, var.defaults.name, null)
  name_prefix                  = try(each.value.name_prefix, var.defaults.name_prefix, null)
  path                         = try(each.value.path, var.defaults.path, "/")
  tags                         = try(each.value.tags, var.defaults.tags, {})
  web_console_services         = try(each.value.web_console_services, var.defaults.web_console_services, ["resource-groups", "tag", "health", "ce"])
}
