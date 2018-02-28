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
