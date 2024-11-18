provider "aws" {
  region = "eu-west-1"
}

######################
# IAM assumable roles
######################
module "iam_assumable_roles" {
  source = "../../modules/iam-assumable-roles"

  trusted_role_arns = [
    "arn:aws:iam::307990089504:root",
    "arn:aws:iam::835367859851:user/anton",
  ]

  trusted_role_services = [
    "codedeploy.amazonaws.com"
  ]

  create_admin_role = true

  create_poweruser_role      = true
  poweruser_role_name        = "Billing-And-Support-Access"
  poweruser_role_policy_arns = ["arn:aws:iam::aws:policy/job-function/Billing", "arn:aws:iam::aws:policy/AWSSupportAccess"]

  create_readonly_role       = true
  readonly_role_requires_mfa = false
}

######################################
# IAM assumable roles with self assume
######################################
module "iam_assumable_roles_with_self_assume" {
  source = "../../modules/iam-assumable-roles"

  trusted_role_arns = [
    "arn:aws:iam::307990089504:root",
    "arn:aws:iam::835367859851:user/anton",
  ]

  trusted_role_services = [
    "codedeploy.amazonaws.com"
  ]

  create_admin_role          = true
  allow_self_assume_role     = true
  create_poweruser_role      = true
  admin_role_name            = "Admin-Role-Name-Self-Assume"
  poweruser_role_name        = "Billing-And-Support-Access-Self-Assume"
  poweruser_role_policy_arns = ["arn:aws:iam::aws:policy/job-function/Billing", "arn:aws:iam::aws:policy/AWSSupportAccess"]
  readonly_role_name         = "Read-Only-Role-Name-Self-Assume"

  create_readonly_role       = true
  readonly_role_requires_mfa = false
}

########################################
# IAM assumable role service conditions
########################################
module "iam_assumable_roles_trusted_accounts" {
  source = "../../modules/iam-assumable-roles"

  trusted_role_services = [
    "codedeploy.amazonaws.com"
  ]
  trusted_source_accounts = [
    "307990089504",
    "835367859851"
  ]

  create_readonly_role = true
  readonly_role_name   = "assumable-roles-trusted-accounts"
}

module "iam_assumable_roles_trusted_arns" {
  source = "../../modules/iam-assumable-roles"

  trusted_role_services = [
    "ssm-incidents.amazonaws.com"
  ]
  trusted_source_arns = [
    "arn:aws:ssm-incidents:*:307990089504:incident-record/myresponseplan/*",
    "arn:aws:ssm-incidents:*:835367859851:incident-record/myresponseplan/*",
  ]

  create_readonly_role = true
  readonly_role_name   = "assumable-roles-trusted-arns"
}

module "iam_assumable_roles_trusted_org_ids" {
  source = "../../modules/iam-assumable-roles"

  trusted_role_services = [
    "codedeploy.amazonaws.com"
  ]
  trusted_source_org_ids = [
    "o-abcdef1234"
  ]

  create_readonly_role = true
  readonly_role_name   = "assumable-roles-trusted-org-ids"
}

module "iam_assumable_roles_trusted_org_paths" {
  source = "../../modules/iam-assumable-roles"

  trusted_role_services = [
    "codedeploy.amazonaws.com"
  ]

  trusted_source_org_paths = [
    "/some/path"
  ]

  create_readonly_role = true
  readonly_role_name   = "assumable-roles-trusted-org-paths"
}
