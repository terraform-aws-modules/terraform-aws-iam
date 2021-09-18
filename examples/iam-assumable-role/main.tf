provider "aws" {
  region = "eu-west-1"
}

###############################
# IAM assumable role for admin
###############################
module "iam_assumable_role_admin" {
  source = "../../modules/iam-assumable-role"

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

  role_name         = "custom"
  role_requires_mfa = false

  role_sts_externalid = "some-id-goes-here"

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonCognitoReadOnly",
    "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess",
    module.iam_policy.arn
  ]
  #  number_of_custom_role_policy_arns = 3
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
