module "wrapper" {
  source = "../../modules/iam-user"

  for_each = var.items

  create_iam_access_key         = try(each.value.create_iam_access_key, var.defaults.create_iam_access_key, true)
  create_iam_user_login_profile = try(each.value.create_iam_user_login_profile, var.defaults.create_iam_user_login_profile, true)
  create_user                   = try(each.value.create_user, var.defaults.create_user, true)
  force_destroy                 = try(each.value.force_destroy, var.defaults.force_destroy, false)
  iam_access_key_status         = try(each.value.iam_access_key_status, var.defaults.iam_access_key_status, null)
  name                          = try(each.value.name, var.defaults.name)
  password_length               = try(each.value.password_length, var.defaults.password_length, 20)
  password_reset_required       = try(each.value.password_reset_required, var.defaults.password_reset_required, true)
  path                          = try(each.value.path, var.defaults.path, "/")
  permissions_boundary          = try(each.value.permissions_boundary, var.defaults.permissions_boundary, "")
  pgp_key                       = try(each.value.pgp_key, var.defaults.pgp_key, "")
  policy_arns                   = try(each.value.policy_arns, var.defaults.policy_arns, [])
  ssh_key_encoding              = try(each.value.ssh_key_encoding, var.defaults.ssh_key_encoding, "SSH")
  ssh_public_key                = try(each.value.ssh_public_key, var.defaults.ssh_public_key, "")
  tags                          = try(each.value.tags, var.defaults.tags, {})
  upload_iam_user_ssh_key       = try(each.value.upload_iam_user_ssh_key, var.defaults.upload_iam_user_ssh_key, false)
}
