################################################################################
# IAM Role w/ OIDC
################################################################################

output "iam_role_name" {
  description = "The name of the IAM role"
  value       = module.iam_role.name
}

output "iam_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the IAM role"
  value       = module.iam_role.arn
}

output "iam_role_unique_id" {
  description = "Stable and unique string identifying the IAM role"
  value       = module.iam_role.unique_id
}
