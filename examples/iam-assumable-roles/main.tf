provider "aws" {
  region = "eu-west-1"
}

#########################################################
# IAM assumable roles with same trusted ARNs and Services
#########################################################
module "iam_assumable_roles" {
  source = "../../modules/iam-assumable-roles"

  trusted_role_arns = [
    "arn:aws:iam::307990089504:root",
    "arn:aws:iam::835367859851:user/anton",
  ]

  trusted_role_services = [
    "codedeploy.amazonaws.com",
  ]

  create_admin_role = true

  create_poweruser_role      = true
  poweruser_role_name        = "Billing-And-Support-Access"
  poweruser_role_policy_arns = [
    "arn:aws:iam::aws:policy/job-function/Billing",
    "arn:aws:iam::aws:policy/AWSSupportAccess",
  ]

  create_readonly_role       = true
  readonly_role_requires_mfa = false
}

##############################################################
# IAM assumable roles with different trusted ARNs and Services
##############################################################
module "iam_assumable_roles_custom_trust" {
  source = "../../modules/iam-assumable-roles"

  trusted_role_arns = [
    "arn:aws:iam::307990089504:root",
    "arn:aws:iam::835367859851:user/anton",
  ]

  trusted_role_services = ["codedeploy.amazonaws.com"]

  # Admin specifc trust for both ARNs and Services
  create_admin_role           = true
  use_custom_admin_role_trust = true
  admin_role_name             = "admin-custom"
  admin_trusted_role_arns     = ["arn:aws:iam::307990089504:root"]
  admin_trusted_role_services = ["ec2fleet.amazonaws.com"]

  # Poweruser specifc trust for ARNs only
  create_poweruser_role           = true
  use_custom_poweruser_role_trust = true
  poweruser_role_name             = "developer"
  poweruser_trusted_role_arns     = ["arn:aws:iam::835367859851:user/anton"]
  poweruser_trusted_role_services = []

  # Readonly inherits trust from default ARNs and Services
  create_readonly_role           = true
  use_custom_readonly_role_trust = false
  readonly_role_name             = "readonly-custom"
  readonly_role_requires_mfa     = false
}
