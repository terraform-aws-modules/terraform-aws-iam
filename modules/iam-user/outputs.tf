################################################################################
# User
################################################################################

output "arn" {
  description = "The ARN assigned by AWS for this user"
  value       = try(aws_iam_user.this[0].arn, null)
}

output "name" {
  description = "The user's name"
  value       = try(aws_iam_user.this[0].name, null)
}

output "unique_id" {
  description = "The unique ID assigned by AWS"
  value       = try(aws_iam_user.this[0].unique_id, null)
}

################################################################################
# User Login Profile
################################################################################

output "login_profile_password" {
  description = "The user password"
  value       = try(aws_iam_user_login_profile.this[0].password, null)
  sensitive   = true
}

output "login_profile_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the password"
  value       = try(aws_iam_user_login_profile.this[0].key_fingerprint, null)
}

output "login_profile_encrypted_password" {
  description = "The encrypted password, base64 encoded"
  value       = try(aws_iam_user_login_profile.this[0].encrypted_password, null)
}

################################################################################
# Access Key
################################################################################

output "access_key_id" {
  description = "The access key ID"
  value       = try(aws_iam_access_key.this[0].id, null)
}

output "access_key_secret" {
  description = "The access key secret"
  value       = try(aws_iam_access_key.this[0].secret, null)
  sensitive   = true
}

output "access_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the secret"
  value       = try(aws_iam_access_key.this[0].key_fingerprint, null)
}

output "access_key_encrypted_secret" {
  description = "The encrypted secret, base64 encoded"
  value       = try(aws_iam_access_key.this[0].encrypted_secret, null)
}

output "access_key_ses_smtp_password_v4" {
  description = "The secret access key converted into an SES SMTP password by applying AWS's Sigv4 conversion algorithm"
  value       = try(aws_iam_access_key.this[0].ses_smtp_password_v4, null)
  sensitive   = true
}

output "access_key_encrypted_ses_smtp_password_v4" {
  description = "The encrypted secret access key converted into an SES SMTP password by applying AWS's Sigv4 conversion algorithm"
  value       = try(aws_iam_access_key.this[0].encrypted_ses_smtp_password_v4, null)
}

output "access_key_status" {
  description = "Active or Inactive. Keys are initially active, but can be made inactive by other means"
  value       = try(aws_iam_access_key.this[0].status, null)
}

################################################################################
# SSH Key
################################################################################

output "ssh_key_public_key_id" {
  description = "The unique identifier for the SSH public key"
  value       = try(aws_iam_user_ssh_key.this[0].ssh_public_key_id, null)
}

output "ssh_key_fingerprint" {
  description = "The MD5 message digest of the SSH public key"
  value       = try(aws_iam_user_ssh_key.this[0].fingerprint, null)
}
