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

####################################################
# Extending policies of IAM group production-admins
####################################################
module "iam_group_with_custom_policy" {
  source = "../../modules/iam-group-with-policies"

  name = "production-admins"

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
  ]
  group_users = [
    module.iam_user1.iam_user_name,
    module.iam_user2.iam_user_name,
  ]
}

#############################################################################################
# IAM group where user1 and user2 are allowed to assume admin role in production AWS account
#############################################################################################
module "iam_group_optional_assumable_roles" {
  source = "../../modules/iam-group-with-assumable-roles-policy"

  name            = module.iam_group_with_custom_policy.group_name
  create_group    = length(var.assumable_roles) > 0
  assumable_roles = var.assumable_roles
}

