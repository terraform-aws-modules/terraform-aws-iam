################################################################################
# User
################################################################################

resource "aws_iam_user" "this" {
  count = var.create ? 1 : 0

  name                 = var.name
  path                 = var.path
  permissions_boundary = var.permissions_boundary
  force_destroy        = var.force_destroy

  tags = var.tags
}

resource "aws_iam_user_policy_attachment" "additional" {
  for_each = { for k, v in var.policies : k => v if var.create }

  user       = aws_iam_user.this[0].name
  policy_arn = each.value
}

################################################################################
# User Login Profile
################################################################################

resource "aws_iam_user_login_profile" "this" {
  count = var.create && var.create_login_profile ? 1 : 0

  user                    = aws_iam_user.this[0].name
  pgp_key                 = var.pgp_key
  password_length         = var.password_length
  password_reset_required = var.password_reset_required
}

################################################################################
# Access Key
################################################################################

resource "aws_iam_access_key" "this" {
  count = var.create && var.create_access_key ? 1 : 0

  user    = aws_iam_user.this[0].name
  pgp_key = var.pgp_key
  status  = var.access_key_status
}

################################################################################
# SSH Key
################################################################################

resource "aws_iam_user_ssh_key" "this" {
  count = var.create && var.create_ssh_key ? 1 : 0

  username   = aws_iam_user.this[0].name
  encoding   = var.ssh_key_encoding
  public_key = var.ssh_public_key
}
