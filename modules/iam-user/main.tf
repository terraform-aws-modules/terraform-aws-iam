resource "aws_iam_user" "this" {
  count = "${var.create_user}"

  name          = "${var.name}"
  path          = "${var.path}"
  force_destroy = "${var.force_destroy}"
}

resource "aws_iam_user_login_profile" "this" {
  count = "${var.create_user && var.create_iam_user_login_profile ? 1 : 0}"

  user                    = "${aws_iam_user.this.name}"
  pgp_key                 = "${var.pgp_key}"
  password_length         = "${var.password_length}"
  password_reset_required = "${var.password_reset_required}"
}

resource "aws_iam_access_key" "this" {
  count = "${var.create_user && var.create_iam_access_key ? 1 : 0}"

  user    = "${aws_iam_user.this.name}"
  pgp_key = "${var.pgp_key}"
}

resource "aws_iam_user_ssh_key" "this" {
  count = "${var.create_user && var.upload_iam_user_ssh_key ? 1 : 0}"

  username   = "${aws_iam_user.this.name}"
  encoding   = "${var.ssh_key_encoding}"
  public_key = "${var.ssh_public_key}"
}
