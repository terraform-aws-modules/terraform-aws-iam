provider "aws" {
  region = "eu-west-1"
}

provider "aws" {
  region = "eu-west-1"

  assume_role {
    role_arn = "arn:aws:iam::835367859851:role/anton-demo"
  }

  alias = "production"
}

data "aws_caller_identity" "iam" {}

data "aws_caller_identity" "production" {
  provider = "aws.production"
}

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
# Several IAM assumable roles (admin, poweruser, readonly) in production AWS account
# Note: Anyone from IAM account can assume them.
#####################################################################################
module "iam_assumable_roles_in_prod" {
  source = "../../modules/iam-assumable-roles"

  trusted_role_arns = [
    "arn:aws:iam::${data.aws_caller_identity.iam.account_id}:root",
  ]

  create_admin_role     = true
  create_poweruser_role = true

  create_readonly_role       = true
  readonly_role_requires_mfa = false

  providers = {
    aws = "aws.production"
  }
}

module "iam_assumable_role_custom" {
  source = "../../modules/iam-assumable-role"

  trusted_role_arns = [
    "arn:aws:iam::${data.aws_caller_identity.iam.account_id}:root",
  ]

  create_role = true

  role_name         = "custom"
  role_requires_mfa = true

  custom_role_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonCognitoReadOnly",
    "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess",
  ]

  providers = {
    aws = "aws.production"
  }
}

################################################################################################
# IAM group where user1 and user2 are allowed to assume readonly role in production AWS account
# Note: IAM AWS account is default, so there is no need to specify it here.
################################################################################################
module "iam_group_with_assumable_roles_policy_production_readonly" {
  source = "../../modules/iam-group-with-assumable-roles-policy"

  name = "production-readonly"

  assumable_roles = [module.iam_assumable_roles_in_prod.readonly_iam_role_arn]

  group_users = [
    module.iam_user1.this_iam_user_name,
    module.iam_user2.this_iam_user_name,
  ]
}

################################################################################################
# IAM group where user1 is allowed to assume admin role in production AWS account
# Note: IAM AWS account is default, so there is no need to specify it here.
################################################################################################
module "iam_group_with_assumable_roles_policy_production_admin" {
  source = "../../modules/iam-group-with-assumable-roles-policy"

  name = "production-admin"

  assumable_roles = [module.iam_assumable_roles_in_prod.admin_iam_role_arn]

  group_users = [
    module.iam_user1.this_iam_user_name,
  ]
}

################################################################################################
# IAM group where user2 is allowed to assume custom role in production AWS account
# Note: IAM AWS account is default, so there is no need to specify it here.
################################################################################################
module "iam_group_with_assumable_roles_policy_production_custom" {
  source = "../../modules/iam-group-with-assumable-roles-policy"

  name = "production-custom"

  assumable_roles = [module.iam_assumable_role_custom.this_iam_role_arn]

  group_users = [
    module.iam_user2.this_iam_user_name,
  ]
}
