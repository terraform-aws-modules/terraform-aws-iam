################################################################################
# GitHub OIDC Provider
################################################################################

output "provider_arn" {
  description = "The ARN assigned by AWS for this provider"
  value       = module.iam_github_oidc_provider.arn
}

output "provider_url" {
  description = "The URL of the identity provider. Corresponds to the iss claim"
  value       = module.iam_github_oidc_provider.url
}

################################################################################
# GitHub OIDC Role
################################################################################

output "iam_role_arn" {
  description = "ARN of IAM role"
  value       = module.iam_github_oidc_role.arn
}

output "iam_role_name" {
  description = "Name of IAM role"
  value       = module.iam_github_oidc_role.name
}

output "iam_role_path" {
  description = "Path of IAM role"
  value       = module.iam_github_oidc_role.path
}

output "iam_role_unique_id" {
  description = "Unique ID of IAM role"
  value       = module.iam_github_oidc_role.unique_id
}
