module "wrapper" {
  source = "../../modules/iam-user"

  for_each = var.items

  access_key_status                = try(each.value.access_key_status, var.defaults.access_key_status, null)
  create                           = try(each.value.create, var.defaults.create, true)
  create_access_key                = try(each.value.create_access_key, var.defaults.create_access_key, true)
  create_inline_policy             = try(each.value.create_inline_policy, var.defaults.create_inline_policy, false)
  create_login_profile             = try(each.value.create_login_profile, var.defaults.create_login_profile, true)
  create_ssh_key                   = try(each.value.create_ssh_key, var.defaults.create_ssh_key, false)
  force_destroy                    = try(each.value.force_destroy, var.defaults.force_destroy, false)
  inline_policy_permissions        = try(each.value.inline_policy_permissions, var.defaults.inline_policy_permissions, null)
  name                             = try(each.value.name, var.defaults.name, "")
  override_inline_policy_documents = try(each.value.override_inline_policy_documents, var.defaults.override_inline_policy_documents, [])
  password_length                  = try(each.value.password_length, var.defaults.password_length, null)
  password_reset_required          = try(each.value.password_reset_required, var.defaults.password_reset_required, true)
  path                             = try(each.value.path, var.defaults.path, null)
  permissions_boundary             = try(each.value.permissions_boundary, var.defaults.permissions_boundary, null)
  pgp_key                          = try(each.value.pgp_key, var.defaults.pgp_key, null)
  policies                         = try(each.value.policies, var.defaults.policies, {})
  source_inline_policy_documents   = try(each.value.source_inline_policy_documents, var.defaults.source_inline_policy_documents, [])
  ssh_key_encoding                 = try(each.value.ssh_key_encoding, var.defaults.ssh_key_encoding, "SSH")
  ssh_public_key                   = try(each.value.ssh_public_key, var.defaults.ssh_public_key, "")
  tags                             = try(each.value.tags, var.defaults.tags, {})
}
