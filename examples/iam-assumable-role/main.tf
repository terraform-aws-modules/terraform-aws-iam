provider "aws" {
  region = "eu-west-1"
}

###############################
# IAM assumable role for admin
###############################
module "iam_assumable_role_admin" {
  source = "../../modules/iam-assumable-role"

  # https://aws.amazon.com/blogs/security/announcing-an-update-to-iam-role-trust-policy-behavior/
  allow_self_assume_role = true

  trusted_role_arns = [
    "arn:aws:iam::307990089504:root",
    "arn:aws:iam::835367859851:user/anton",
  ]

  trusted_role_services = [
    "codedeploy.amazonaws.com"
  ]

  create_role             = true
  create_instance_profile = true

  role_name         = "admin"
  role_requires_mfa = true

  attach_admin_policy = true

  tags = {
    Role = "Admin"
  }
}

##########################################
# IAM assumable role with custom policies
##########################################
module "iam_assumable_role_custom" {
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

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonCognitoReadOnly",
    "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess",
    module.iam_policy.arn
  ]
  #  number_of_custom_role_policy_arns = 3
}

##########################################
# IAM assumable role with inline policy
##########################################
module "iam_assumable_role_inline_policy" {
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

####################################################
# IAM assumable role with multiple sts external ids
####################################################
module "iam_assumable_role_sts" {
  source = "../../modules/iam-assumable-role"

  trusted_role_arns = [
    "arn:aws:iam::307990089504:root",
  ]

  trusted_role_services = [
    "codedeploy.amazonaws.com"
  ]

  create_role = true

  role_name         = "custom_sts"
  role_requires_mfa = true

  role_sts_externalid = [
    "some-id-goes-here",
    "another-id-goes-here",
  ]

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonCognitoReadOnly",
    "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess",
    module.iam_policy.arn
  ]
  #  number_of_custom_role_policy_arns = 3
}

#########################################
# IAM assumable role with custom trust policy
#########################################
module "iam_assumable_role_custom_trust_policy" {
  source = "../../modules/iam-assumable-role"

  create_role = true

  role_name = "iam_assumable_role_custom_trust_policy"

  create_custom_role_trust_policy = true
  custom_role_trust_policy        = data.aws_iam_policy_document.custom_trust_policy.json
  custom_role_policy_arns         = ["arn:aws:iam::aws:policy/AmazonCognitoReadOnly"]
}

data "aws_iam_policy_document" "custom_trust_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = ["some-ext-id"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalOrgID"
      values   = ["o-someorgid"]
    }

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
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
}

########################################
# IAM assumable role service conditions
########################################
module "iam_assumable_role_trusted_accounts" {
  source = "../../modules/iam-assumable-role"

  trusted_role_services = [
    "codedeploy.amazonaws.com"
  ]
  trusted_source_accounts = [
    "307990089504",
    "835367859851"
  ]

  create_role       = true
  role_requires_mfa = false
  role_name_prefix  = "assumable-role-policy-test-"
}

module "iam_assumable_role_trusted_arns" {
  source = "../../modules/iam-assumable-role"

  trusted_role_services = [
    "ssm-incidents.amazonaws.com"
  ]
  trusted_source_arns = [
    "arn:aws:ssm-incidents:*:307990089504:incident-record/myresponseplan/*",
    "arn:aws:ssm-incidents:*:835367859851:incident-record/myresponseplan/*",
  ]

  create_role       = true
  role_requires_mfa = false
  role_name_prefix  = "assumable-role-policy-test-"
}

module "iam_assumable_role_trusted_org_ids" {
  source = "../../modules/iam-assumable-role"

  trusted_role_services = [
    "codedeploy.amazonaws.com"
  ]
  trusted_source_org_ids = [
    "o-someorgid"
  ]

  create_role       = true
  role_requires_mfa = false
  role_name_prefix  = "assumable-role-policy-test-"
}

module "iam_assumable_role_trusted_org_paths" {
  source = "../../modules/iam-assumable-role"

  trusted_role_services = [
    "codedeploy.amazonaws.com"
  ]

  trusted_source_org_paths = [
    "/some/org/path"
  ]

  create_role       = true
  role_requires_mfa = false
  role_name_prefix  = "assumable-role-policy-test-"
}
