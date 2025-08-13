################################################################################
# GitHub OIDC Provider & Role
################################################################################

output "github_oidc_iam_provider_arn" {
  description = "The ARN assigned by AWS for this provider"
  value       = module.github_oidc_iam_provider.arn
}

output "github_oidc_iam_provider_url" {
  description = "The URL of the identity provider. Corresponds to the iss claim"
  value       = module.github_oidc_iam_provider.url
}

output "github_oidc_iam_role_arn" {
  description = "ARN of IAM role"
  value       = module.github_oidc_iam_role.arn
}

output "github_oidc_iam_role_name" {
  description = "Name of IAM role"
  value       = module.github_oidc_iam_role.name
}

output "github_oidc_iam_role_unique_id" {
  description = "Unique ID of IAM role"
  value       = module.github_oidc_iam_role.unique_id
}
