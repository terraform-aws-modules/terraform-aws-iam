################################################################################
# IAM User
################################################################################

output "iam_user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = module.iam_user.arn
}

output "iam_user_name" {
  description = "The user's name"
  value       = module.iam_user.name
}

output "iam_user_unique_id" {
  description = "The unique ID assigned by AWS"
  value       = module.iam_user.unique_id
}

output "iam_user_login_profile_password" {
  description = "The user password"
  value       = module.iam_user.login_profile_password
  sensitive   = true
}

output "iam_user_login_profile_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the password"
  value       = module.iam_user.login_profile_key_fingerprint
}

output "iam_user_login_profile_encrypted_password" {
  description = "The encrypted password, base64 encoded"
  value       = module.iam_user.login_profile_encrypted_password
}

output "iam_user_access_key_id" {
  description = "The access key ID"
  value       = module.iam_user.access_key_id
}

output "iam_user_access_key_secret" {
  description = "The access key secret"
  value       = module.iam_user.access_key_secret
  sensitive   = true
}

output "iam_user_access_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the secret"
  value       = module.iam_user.access_key_fingerprint
}

output "iam_user_access_key_encrypted_secret" {
  description = "The encrypted secret, base64 encoded"
  value       = module.iam_user.access_key_encrypted_secret
}

output "iam_user_access_key_ses_smtp_password_v4" {
  description = "The secret access key converted into an SES SMTP password by applying AWS's Sigv4 conversion algorithm"
  value       = module.iam_user.access_key_ses_smtp_password_v4
  sensitive   = true
}

output "iam_user_access_key_encrypted_ses_smtp_password_v4" {
  description = "The encrypted secret access key converted into an SES SMTP password by applying AWS's Sigv4 conversion algorithm"
  value       = module.iam_user.access_key_encrypted_ses_smtp_password_v4
}

output "iam_user_access_key_status" {
  description = "Active or Inactive. Keys are initially active, but can be made inactive by other means"
  value       = module.iam_user.access_key_status
}

output "iam_user_ssh_key_public_key_id" {
  description = "The unique identifier for the SSH public key"
  value       = module.iam_user.ssh_key_public_key_id
}

output "iam_user_ssh_key_fingerprint" {
  description = "The MD5 message digest of the SSH public key"
  value       = module.iam_user.ssh_key_fingerprint
}

################################################################################
# IAM User 2
################################################################################

output "iam_user2_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = module.iam_user2.arn
}

output "iam_user2_name" {
  description = "The user's name"
  value       = module.iam_user2.name
}

output "iam_user2_unique_id" {
  description = "The unique ID assigned by AWS"
  value       = module.iam_user2.unique_id
}

output "iam_user2_login_profile_password" {
  description = "The user password"
  value       = module.iam_user2.login_profile_password
  sensitive   = true
}

output "iam_user2_login_profile_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the password"
  value       = module.iam_user2.login_profile_key_fingerprint
}

output "iam_user2_login_profile_encrypted_password" {
  description = "The encrypted password, base64 encoded"
  value       = module.iam_user2.login_profile_encrypted_password
}

output "iam_user2_access_key_id" {
  description = "The access key ID"
  value       = module.iam_user2.access_key_id
}

output "iam_user2_access_key_secret" {
  description = "The access key secret"
  value       = module.iam_user2.access_key_secret
  sensitive   = true
}

output "iam_user2_access_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the secret"
  value       = module.iam_user2.access_key_fingerprint
}

output "iam_user2_access_key_encrypted_secret" {
  description = "The encrypted secret, base64 encoded"
  value       = module.iam_user2.access_key_encrypted_secret
}

output "iam_user2_access_key_ses_smtp_password_v4" {
  description = "The secret access key converted into an SES SMTP password by applying AWS's Sigv4 conversion algorithm"
  value       = module.iam_user2.access_key_ses_smtp_password_v4
  sensitive   = true
}

output "iam_user2_access_key_encrypted_ses_smtp_password_v4" {
  description = "The encrypted secret access key converted into an SES SMTP password by applying AWS's Sigv4 conversion algorithm"
  value       = module.iam_user2.access_key_encrypted_ses_smtp_password_v4
}

output "iam_user2_access_key_status" {
  description = "Active or Inactive. Keys are initially active, but can be made inactive by other means"
  value       = module.iam_user2.access_key_status
}

output "iam_user2_ssh_key_public_key_id" {
  description = "The unique identifier for the SSH public key"
  value       = module.iam_user2.ssh_key_public_key_id
}

output "iam_user2_ssh_key_fingerprint" {
  description = "The MD5 message digest of the SSH public key"
  value       = module.iam_user2.ssh_key_fingerprint
}

################################################################################
# IAM User 3
################################################################################

output "iam_user3_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = module.iam_user3.arn
}

output "iam_user3_name" {
  description = "The user's name"
  value       = module.iam_user3.name
}

output "iam_user3_unique_id" {
  description = "The unique ID assigned by AWS"
  value       = module.iam_user3.unique_id
}

output "iam_user3_login_profile_password" {
  description = "The user password"
  value       = module.iam_user3.login_profile_password
  sensitive   = true
}

output "iam_user3_login_profile_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the password"
  value       = module.iam_user3.login_profile_key_fingerprint
}

output "iam_user3_login_profile_encrypted_password" {
  description = "The encrypted password, base64 encoded"
  value       = module.iam_user3.login_profile_encrypted_password
}

output "iam_user3_access_key_id" {
  description = "The access key ID"
  value       = module.iam_user3.access_key_id
}

output "iam_user3_access_key_secret" {
  description = "The access key secret"
  value       = module.iam_user3.access_key_secret
  sensitive   = true
}

output "iam_user3_access_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the secret"
  value       = module.iam_user3.access_key_fingerprint
}

output "iam_user3_access_key_encrypted_secret" {
  description = "The encrypted secret, base64 encoded"
  value       = module.iam_user3.access_key_encrypted_secret
}

output "iam_user3_access_key_ses_smtp_password_v4" {
  description = "The secret access key converted into an SES SMTP password by applying AWS's Sigv4 conversion algorithm"
  value       = module.iam_user3.access_key_ses_smtp_password_v4
  sensitive   = true
}

output "iam_user3_access_key_encrypted_ses_smtp_password_v4" {
  description = "The encrypted secret access key converted into an SES SMTP password by applying AWS's Sigv4 conversion algorithm"
  value       = module.iam_user3.access_key_encrypted_ses_smtp_password_v4
}

output "iam_user3_access_key_status" {
  description = "Active or Inactive. Keys are initially active, but can be made inactive by other means"
  value       = module.iam_user3.access_key_status
}

output "iam_user3_ssh_key_public_key_id" {
  description = "The unique identifier for the SSH public key"
  value       = module.iam_user3.ssh_key_public_key_id
}

output "iam_user3_ssh_key_fingerprint" {
  description = "The MD5 message digest of the SSH public key"
  value       = module.iam_user3.ssh_key_fingerprint
}
