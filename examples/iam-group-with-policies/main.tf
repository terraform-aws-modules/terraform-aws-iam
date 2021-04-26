############
# IAM users
############
module "iam_user1" {
  source = "../../modules/iam-user"

  name = "user1"

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}

module "iam_user2" {
  source = "../../modules/iam-user"

  name = "user2"

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}

#####################################################################################
# IAM group for superadmins with full Administrator access
#####################################################################################
module "iam_group_superadmins" {
  source = "../../modules/iam-group-with-policies"

  name = "superadmins"

  group_users = [
    module.iam_user1.iam_user_name,
    module.iam_user2.iam_user_name,
  ]

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
  ]
}

#####################################################################################
# IAM group for users with custom access
#####################################################################################
module "iam_group_with_custom_policies" {
  source = "../../modules/iam-group-with-policies"

  name = "custom"

  group_users = [
    module.iam_user1.iam_user_name,
    module.iam_user2.iam_user_name,
  ]

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonCognitoReadOnly",
    "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess",
  ]

  custom_group_policies = [
    {
      name   = "AllowS3Listing"
      policy = data.aws_iam_policy_document.sample.json
    },
  ]
}

######################
# IAM policy (sample)
######################
data "aws_iam_policy_document" "sample" {
  statement {
    actions = [
      "s3:ListBuckets",
    ]

    resources = ["*"]
  }
}
