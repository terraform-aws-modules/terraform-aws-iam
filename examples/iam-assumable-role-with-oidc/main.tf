provider "aws" {
  region = "eu-west-1"
}

###############################
# IAM assumable role for admin
###############################
module "iam_assumable_role_admin" {
  source = "../../modules/iam-assumable-role-with-oidc"

  create_role = true

  role_name = "role-with-oidc"

  tags = {
    Role = "role-with-oidc"
  }

  provider_url = "oidc.circleci.com/org/<CIRCLECI_ORG_UUID>"

  oidc_fully_qualified_audiences = ["<CIRCLECI_ORG_UUID>"]

  role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser",
  ]
}

#####################################
# IAM assumable role with self assume
#####################################
module "iam_assumable_role_self_assume" {
  source = "../../modules/iam-assumable-role-with-oidc"

  create_role            = true
  allow_self_assume_role = true

  role_name = "role-with-oidc-self-assume"

  tags = {
    Role = "role-with-oidc-self-assume"
  }

  provider_url = "oidc.circleci.com/org/<CIRCLECI_ORG_UUID>"

  oidc_fully_qualified_audiences = ["<CIRCLECI_ORG_UUID>"]

  role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser",
  ]
}

#######################################
# IAM assumable role with inline policy
#######################################
module "iam_assumable_role_inline_policy" {
  source = "../../modules/iam-assumable-role-with-oidc"

  create_role = true

  role_name = "role-with-oidc-inline-policy"

  tags = {
    Role = "role-with-oidc-inline-policy"
  }

  provider_url = "oidc.circleci.com/org/<CIRCLECI_ORG_UUID>"

  oidc_fully_qualified_audiences = ["<CIRCLECI_ORG_UUID>"]

  inline_policy_statements = [
    {
      sid = "AllowECRPushPull"
      actions = [
        "ecr:GetAuthorizationToken",
        "ecr:BatchGetImage",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchCheckLayerAvailability",
        "ecr:DescribeImages",
        "ecr:DescribeRepositories",
        "ecr:GetDownloadUrlForLayer",
        "ecr:ListImages",
        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload"
      ]
      effect    = "Allow"
      resources = ["*"]
    }
  ]
}

module "iam_assumable_role_inline_policy_json" {
  source = "../../modules/iam-assumable-role"

  trusted_role_arns = [
    "arn:aws:iam::307990089504:root",
  ]

  trusted_role_services = [
    "codedeploy.amazonaws.com"
  ]

  create_role = true

  role_name_prefix  = "custom-"
  role_requires_mfa = false

  role_sts_externalid = "some-id-goes-here"

  inline_policy_json_document = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowECRPushPull",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchGetImage",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchCheckLayerAvailability",
        "ecr:DescribeImages",
        "ecr:DescribeRepositories",
        "ecr:GetDownloadUrlForLayer",
        "ecr:ListImages",
        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
