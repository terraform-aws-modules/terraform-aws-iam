data "aws_iam_policy_document" "assume_role_with_saml" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRoleWithSAML"]

    principals {
      type        = "Federated"
      identifiers = ["${var.provider_id}"]
    }

    condition {
      test     = "StringEquals"
      variable = "SAML:aud"
      values   = ["${var.aws_saml_endpoint}"]
    }
  }
}

# Admin
resource "aws_iam_role" "admin" {
  count = "${var.create_admin_role ? 1 : 0}"

  name                 = "${var.admin_role_name}"
  path                 = "${var.admin_role_path}"
  max_session_duration = "${var.max_session_duration}"

  permissions_boundary = "${var.admin_role_permissions_boundary_arn}"

  assume_role_policy = "${data.aws_iam_policy_document.assume_role_with_saml.json}"
}

resource "aws_iam_role_policy_attachment" "admin" {
  count = "${var.create_admin_role ? 1 : 0}"

  role       = "${aws_iam_role.admin.name}"
  policy_arn = "${var.admin_role_policy_arn}"
}

# Poweruser
resource "aws_iam_role_policy_attachment" "poweruser" {
  count = "${var.create_poweruser_role ? 1 : 0}"

  role       = "${aws_iam_role.poweruser.name}"
  policy_arn = "${var.poweruser_role_policy_arn}"
}

resource "aws_iam_role" "poweruser" {
  count = "${var.create_poweruser_role ? 1 : 0}"

  name                 = "${var.poweruser_role_name}"
  path                 = "${var.poweruser_role_path}"
  max_session_duration = "${var.max_session_duration}"

  permissions_boundary = "${var.poweruser_role_permissions_boundary_arn}"

  assume_role_policy = "${data.aws_iam_policy_document.assume_role_with_saml.json}"
}

# Readonly
resource "aws_iam_role_policy_attachment" "readonly" {
  count = "${var.create_readonly_role ? 1 : 0}"

  role       = "${aws_iam_role.readonly.name}"
  policy_arn = "${var.readonly_role_policy_arn}"
}

resource "aws_iam_role" "readonly" {
  count = "${var.create_readonly_role ? 1 : 0}"

  name                 = "${var.readonly_role_name}"
  path                 = "${var.readonly_role_path}"
  max_session_duration = "${var.max_session_duration}"

  permissions_boundary = "${var.readonly_role_permissions_boundary_arn}"

  assume_role_policy = "${data.aws_iam_policy_document.assume_role_with_saml.json}"
}
