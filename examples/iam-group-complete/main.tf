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

#############################################################################################
# IAM group where user1 and user2 are allowed to assume admin role in production AWS account
#############################################################################################
module "iam_group_complete" {
  source = "../../modules/iam-group-with-assumable-roles-policy"

  name = "production-admins"

  assumable_roles = ["arn:aws:iam::111111111111:role/admin"]

  group_users = [
    module.iam_user1.this_iam_user_name,
    module.iam_user2.this_iam_user_name,
  ]
}

####################################################
# Extending policies of IAM group production-admins
####################################################
module "iam_group_complete_with_custom_policy" {
  source = "../../modules/iam-group-with-policies"

  name = module.iam_group_complete.group_name

  create_group = false

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  ]
}
