output "this_iam_role_arn" {
  description = "ARN of IAM role"
  value       = module.iam_assumable_role_admin.this_iam_role_arn
}

output "this_iam_role_name" {
  description = "Name of IAM role"
  value       = module.iam_assumable_role_admin.this_iam_role_name
}

output "this_iam_role_path" {
  description = "Path of IAM role"
  value       = module.iam_assumable_role_admin.this_iam_role_path
}

output "role_requires_mfa" {
  description = "Whether admin IAM role requires MFA"
  value       = module.iam_assumable_role_admin.role_requires_mfa
}
