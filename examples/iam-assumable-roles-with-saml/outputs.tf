# Admin
output "admin_iam_role_arn" {
  description = "ARN of admin IAM role"
  value       = module.iam_assumable_roles_with_saml.admin_iam_role_arn
}

output "admin_iam_role_name" {
  description = "Name of admin IAM role"
  value       = module.iam_assumable_roles_with_saml.admin_iam_role_name
}

output "admin_iam_role_path" {
  description = "Path of admin IAM role"
  value       = module.iam_assumable_roles_with_saml.admin_iam_role_path
}

# Poweruser
output "poweruser_iam_role_arn" {
  description = "ARN of poweruser IAM role"
  value       = module.iam_assumable_roles_with_saml.poweruser_iam_role_arn
}

output "poweruser_iam_role_name" {
  description = "Name of poweruser IAM role"
  value       = module.iam_assumable_roles_with_saml.poweruser_iam_role_name
}

output "poweruser_iam_role_path" {
  description = "Path of poweruser IAM role"
  value       = module.iam_assumable_roles_with_saml.poweruser_iam_role_path
}

# Readonly
output "readonly_iam_role_arn" {
  description = "ARN of readonly IAM role"
  value       = module.iam_assumable_roles_with_saml.readonly_iam_role_arn
}

output "readonly_iam_role_name" {
  description = "Name of readonly IAM role"
  value       = module.iam_assumable_roles_with_saml.readonly_iam_role_name
}

output "readonly_iam_role_path" {
  description = "Path of readonly IAM role"
  value       = module.iam_assumable_roles_with_saml.readonly_iam_role_path
}
