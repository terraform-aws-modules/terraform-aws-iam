################################################################################
# GitHub OIDC Provider
################################################################################

output "arn" {
  description = "The ARN assigned by AWS for this provider"
  value       = try(aws_iam_openid_connect_provider.this[0].arn, null)
}

output "url" {
  description = "The URL of the identity provider. Corresponds to the iss claim"
  value       = try(aws_iam_openid_connect_provider.this[0].url, null)
}
