#Admin
output "admin_iam_role_arn" {
  description = "ARN of admin IAM role"
  value       = element(concat(aws_iam_role.admin.*.arn, [""]), 0)
}

output "admin_iam_role_name" {
  description = "Name of admin IAM role"
  value       = element(concat(aws_iam_role.admin.*.name, [""]), 0)
}

output "admin_iam_role_path" {
  description = "Path of admin IAM role"
  value       = element(concat(aws_iam_role.admin.*.path, [""]), 0)
}

output "admin_iam_role_requires_mfa" {
  description = "Whether admin IAM role requires MFA"
  value       = var.admin_role_requires_mfa
}

# Poweruser
output "poweruser_iam_role_arn" {
  description = "ARN of poweruser IAM role"
  value       = element(concat(aws_iam_role.poweruser.*.arn, [""]), 0)
}

output "poweruser_iam_role_name" {
  description = "Name of poweruser IAM role"
  value       = element(concat(aws_iam_role.poweruser.*.name, [""]), 0)
}

output "poweruser_iam_role_path" {
  description = "Path of poweruser IAM role"
  value       = element(concat(aws_iam_role.poweruser.*.path, [""]), 0)
}

output "poweruser_iam_role_requires_mfa" {
  description = "Whether poweruser IAM role requires MFA"
  value       = var.poweruser_role_requires_mfa
}

# Readonly
output "readonly_iam_role_arn" {
  description = "ARN of readonly IAM role"
  value       = element(concat(aws_iam_role.readonly.*.arn, [""]), 0)
}

output "readonly_iam_role_name" {
  description = "Name of readonly IAM role"
  value       = element(concat(aws_iam_role.readonly.*.name, [""]), 0)
}

output "readonly_iam_role_path" {
  description = "Path of readonly IAM role"
  value       = element(concat(aws_iam_role.readonly.*.path, [""]), 0)
}

output "readonly_iam_role_requires_mfa" {
  description = "Whether readonly IAM role requires MFA"
  value       = var.readonly_role_requires_mfa
}

