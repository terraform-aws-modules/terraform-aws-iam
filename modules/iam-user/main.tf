resource "aws_iam_user" "this" {
  count = var.create_user ? 1 : 0

  name                 = var.name
  path                 = var.path
  force_destroy        = var.force_destroy
  permissions_boundary = var.permissions_boundary

  tags = var.tags
}

resource "aws_iam_user_login_profile" "this" {
  count = var.create_user && var.create_iam_user_login_profile ? 1 : 0

  user                    = aws_iam_user.this[0].name
  pgp_key                 = var.pgp_key
  password_length         = var.password_length
  password_reset_required = var.password_reset_required

  # TODO: Remove once https://github.com/hashicorp/terraform-provider-aws/issues/23567 is resolved
  lifecycle {
    ignore_changes = [password_reset_required]
  }
}

resource "aws_iam_access_key" "this" {
  count = var.create_user && var.create_iam_access_key && var.pgp_key != "" ? 1 : 0

  user    = aws_iam_user.this[0].name
  pgp_key = var.pgp_key
}

resource "aws_iam_access_key" "this_no_pgp" {
  count = var.create_user && var.create_iam_access_key && var.pgp_key == "" ? 1 : 0

  user = aws_iam_user.this[0].name
}

resource "aws_iam_user_ssh_key" "this" {
  count = var.create_user && var.upload_iam_user_ssh_key ? 1 : 0

  username   = aws_iam_user.this[0].name
  encoding   = var.ssh_key_encoding
  public_key = var.ssh_public_key
}

resource "aws_iam_policy" "this" {
  for_each = {
    for key, values in var.iam_policies : key => values
    if var.create_iam_policies && length(var.iam_policies) > 0
  }

  name        = each.key
  name_prefix = lookup(each.value, "name_prefix", null)
  path        = lookup(each.value, "path", null)
  description = lookup(each.value, "description", null)

  policy = each.value.policy

  tags = lookup(each.value, "tags", null)
}

resource "aws_iam_user_policy_attachment" "created_iam_policies" {
  for_each = aws_iam_policy.this

  user       = aws_iam_user.this[0].name
  policy_arn = each.value.arn
}

resource "aws_iam_user_policy_attachment" "existing_iam_policies" {
  for_each = toset(var.attach_iam_arn_policies)

  user       = aws_iam_user.this[0].name
  policy_arn = each.value
}
