#Admin
output "admin_iam_role_arn" {
  description = "ARN of admin IAM role"
  value       = try(aws_iam_role.admin[0].arn, "")
}

output "admin_iam_role_name" {
  description = "Name of admin IAM role"
  value       = try(aws_iam_role.admin[0].name, "")
}

output "admin_iam_role_path" {
  description = "Path of admin IAM role"
  value       = try(aws_iam_role.admin[0].path, "")
}

output "admin_iam_role_unique_id" {
  description = "Unique ID of IAM role"
  value       = try(aws_iam_role.admin[0].unique_id, "")
}

output "admin_iam_role_requires_mfa" {
  description = "Whether admin IAM role requires MFA"
  value       = var.admin_role_requires_mfa
}

# Poweruser
output "poweruser_iam_role_arn" {
  description = "ARN of poweruser IAM role"
  value       = try(aws_iam_role.poweruser[0].arn, "")
}

output "poweruser_iam_role_name" {
  description = "Name of poweruser IAM role"
  value       = try(aws_iam_role.poweruser[0].name, "")
}

output "poweruser_iam_role_path" {
  description = "Path of poweruser IAM role"
  value       = try(aws_iam_role.poweruser[0].path, "")
}

output "poweruser_iam_role_unique_id" {
  description = "Unique ID of IAM role"
  value       = try(aws_iam_role.poweruser[0].unique_id, "")
}

output "poweruser_iam_role_requires_mfa" {
  description = "Whether poweruser IAM role requires MFA"
  value       = var.poweruser_role_requires_mfa
}

# Readonly
output "readonly_iam_role_arn" {
  description = "ARN of readonly IAM role"
  value       = try(aws_iam_role.readonly[0].arn, "")
}

output "readonly_iam_role_name" {
  description = "Name of readonly IAM role"
  value       = try(aws_iam_role.readonly[0].name, "")
}

output "readonly_iam_role_path" {
  description = "Path of readonly IAM role"
  value       = try(aws_iam_role.readonly[0].path, "")
}

output "readonly_iam_role_unique_id" {
  description = "Unique ID of IAM role"
  value       = try(aws_iam_role.readonly[0].unique_id, "")
}

output "readonly_iam_role_requires_mfa" {
  description = "Whether readonly IAM role requires MFA"
  value       = var.readonly_role_requires_mfa
}
