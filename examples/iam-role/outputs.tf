################################################################################
# IAM Role - Instance Profile
################################################################################

output "instance_profile_iam_role_name" {
  description = "The name of the IAM role"
  value       = module.iam_role_instance_profile.name
}

output "instance_profile_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = module.iam_role_instance_profile.arn
}

output "instance_profile_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.iam_role_instance_profile.unique_id
}

output "instance_profile_iam_instance_profile_arn" {
  description = "ARN assigned by AWS to the instance profile"
  value       = module.iam_role_instance_profile.instance_profile_arn
}

output "instance_profile_iam_instance_profile_id" {
  description = "Instance profile's ID"
  value       = module.iam_role_instance_profile.instance_profile_id
}

output "instance_profile_iam_instance_profile_name" {
  description = "Name of IAM instance profile"
  value       = module.iam_role_instance_profile.instance_profile_name
}

output "instance_profile_iam_instance_profile_unique_id" {
  description = "Stable and unique string identifying the IAM instance profile"
  value       = module.iam_role_instance_profile.instance_profile_unique_id
}

################################################################################
# IAM Role - GitHub OIDC
################################################################################

output "github_oidc_iam_role_name" {
  description = "The name of the IAM role"
  value       = module.iam_role_github_oidc.name
}

output "github_oidc_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = module.iam_role_github_oidc.arn
}

output "github_oidc_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.iam_role_github_oidc.unique_id
}

output "github_oidc_iam_instance_profile_arn" {
  description = "ARN assigned by AWS to the instance profile"
  value       = module.iam_role_github_oidc.instance_profile_arn
}

output "github_oidc_iam_instance_profile_id" {
  description = "Instance profile's ID"
  value       = module.iam_role_github_oidc.instance_profile_id
}

output "github_oidc_iam_instance_profile_name" {
  description = "Name of IAM instance profile"
  value       = module.iam_role_github_oidc.instance_profile_name
}

output "github_oidc_iam_instance_profile_unique_id" {
  description = "Stable and unique string identifying the IAM instance profile"
  value       = module.iam_role_github_oidc.instance_profile_unique_id
}

################################################################################
# IAM Role - CircleCI OIDC
################################################################################

output "circleci_oidc_iam_role_name" {
  description = "The name of the IAM role"
  value       = module.iam_role_circleci_oidc.name
}

output "circleci_oidc_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = module.iam_role_circleci_oidc.arn
}

output "circleci_oidc_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.iam_role_circleci_oidc.unique_id
}

output "circleci_oidc_iam_instance_profile_arn" {
  description = "ARN assigned by AWS to the instance profile"
  value       = module.iam_role_circleci_oidc.instance_profile_arn
}

output "circleci_oidc_iam_instance_profile_id" {
  description = "Instance profile's ID"
  value       = module.iam_role_circleci_oidc.instance_profile_id
}

output "circleci_oidc_iam_instance_profile_name" {
  description = "Name of IAM instance profile"
  value       = module.iam_role_circleci_oidc.instance_profile_name
}

output "circleci_oidc_iam_instance_profile_unique_id" {
  description = "Stable and unique string identifying the IAM instance profile"
  value       = module.iam_role_circleci_oidc.instance_profile_unique_id
}

################################################################################
# IAM Role - SAML 2.0
################################################################################

output "saml_iam_role_name" {
  description = "The name of the IAM role"
  value       = module.iam_role_saml.name
}

output "saml_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = module.iam_role_saml.arn
}

output "saml_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.iam_role_saml.unique_id
}

output "saml_iam_instance_profile_arn" {
  description = "ARN assigned by AWS to the instance profile"
  value       = module.iam_role_saml.instance_profile_arn
}

output "saml_iam_instance_profile_id" {
  description = "Instance profile's ID"
  value       = module.iam_role_saml.instance_profile_id
}

output "saml_iam_instance_profile_name" {
  description = "Name of IAM instance profile"
  value       = module.iam_role_saml.instance_profile_name
}

output "saml_iam_instance_profile_unique_id" {
  description = "Stable and unique string identifying the IAM instance profile"
  value       = module.iam_role_saml.instance_profile_unique_id
}

################################################################################
# IAM Role - Inline Policy
################################################################################

output "inline_policy_iam_role_name" {
  description = "The name of the IAM role"
  value       = module.iam_role_inline_policy.name
}

output "inline_policy_iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = module.iam_role_inline_policy.arn
}

output "inline_policy_iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.iam_role_inline_policy.unique_id
}

output "inline_policy_iam_instance_profile_arn" {
  description = "ARN assigned by AWS to the instance profile"
  value       = module.iam_role_inline_policy.instance_profile_arn
}

output "inline_policy_iam_instance_profile_id" {
  description = "Instance profile's ID"
  value       = module.iam_role_inline_policy.instance_profile_id
}

output "inline_policy_iam_instance_profile_name" {
  description = "Name of IAM instance profile"
  value       = module.iam_role_inline_policy.instance_profile_name
}

output "inline_policy_iam_instance_profile_unique_id" {
  description = "Stable and unique string identifying the IAM instance profile"
  value       = module.iam_role_inline_policy.instance_profile_unique_id
}
