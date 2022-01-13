provider "aws" {
  region = "eu-west-1"
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid       = "AllowFullS3Access"
    actions   = ["s3:ListAllMyBuckets"]
    resources = ["*"]
  }
}

#########################################
# IAM policy
#########################################
module "iam_policy" {
  source = "../../modules/iam-policy"

  name        = "example"
  path        = "/"
  description = "My example policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

  tags = {
    PolicyDescription = "Policy created using heredoc policy"
  }
}

module "iam_policy_from_data_source" {
  source = "../../modules/iam-policy"

  name        = "example_from_data_source"
  path        = "/"
  description = "My example policy"

  policy = data.aws_iam_policy_document.bucket_policy.json

  tags = {
    PolicyDescription = "Policy created using example from data source"
  }
}

module "iam_policy_optional" {
  source = "../../modules/iam-policy"

  create_policy = false
}
