resource "aws_iam_role" "role" {
  name = "test-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "NotPrincipal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Deny",
      "Sid": ""
    }
  ]
}
EOF
}