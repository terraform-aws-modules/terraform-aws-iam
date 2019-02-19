
data "template_file" "policy" {
    template = "${file("${var.policy}")}"
}

resource "aws_iam_policy" "policy" {
  name        = "${var.name}"
  path        = "${var.path}"
  description = "${var.description}"

  policy = "${data.template_file.policy.rendered}"
}
