# Admin
output "admin_iam_role_arn" {
  description = "ARN of admin IAM role"
  value       = "${module.iam_assumable_roles.admin_iam_role_arn}"
}

output "admin_iam_role_name" {
  description = "Name of admin IAM role"
  value       = "${module.iam_assumable_roles.admin_iam_role_name}"
}

output "admin_iam_role_requires_mfa" {
  description = "Whether admin IAM role requires MFA"
  value       = "${module.iam_assumable_roles.admin_iam_role_requires_mfa}"
}

output "admin_iam_role_path" {
  description = "Path of admin IAM role"
  value       = "${module.iam_assumable_roles.admin_iam_role_path}"
}

# Poweruser
output "poweruser_iam_role_arn" {
  description = "ARN of poweruser IAM role"
  value       = "${module.iam_assumable_roles.poweruser_iam_role_arn}"
}

output "poweruser_iam_role_name" {
  description = "Name of poweruser IAM role"
  value       = "${module.iam_assumable_roles.poweruser_iam_role_name}"
}

output "poweruser_iam_role_requires_mfa" {
  description = "Whether poweruser IAM role requires MFA"
  value       = "${module.iam_assumable_roles.poweruser_iam_role_requires_mfa}"
}

output "poweruser_iam_role_path" {
  description = "Path of poweruser IAM role"
  value       = "${module.iam_assumable_roles.poweruser_iam_role_path}"
}

# Readonly
output "readonly_iam_role_arn" {
  description = "ARN of readonly IAM role"
  value       = "${module.iam_assumable_roles.readonly_iam_role_arn}"
}

output "readonly_iam_role_name" {
  description = "Name of readonly IAM role"
  value       = "${module.iam_assumable_roles.readonly_iam_role_name}"
}

output "readonly_iam_role_path" {
  description = "Path of readonly IAM role"
  value       = "${module.iam_assumable_roles.readonly_iam_role_path}"
}

output "readonly_iam_role_requires_mfa" {
  description = "Whether readonly IAM role requires MFA"
  value       = "${module.iam_assumable_roles.readonly_iam_role_requires_mfa}"
}
