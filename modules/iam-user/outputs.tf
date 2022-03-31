locals {
  has_encrypted_password = length(compact(aws_iam_user_login_profile.this[*].encrypted_password)) > 0
  has_encrypted_secret   = length(compact(aws_iam_access_key.this[*].encrypted_secret)) > 0
}

output "iam_user_name" {
  description = "The user's name"
  value       = try(aws_iam_user.this[0].name, "")
}

output "iam_user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = try(aws_iam_user.this[0].arn, "")
}

output "iam_user_unique_id" {
  description = "The unique ID assigned by AWS"
  value       = try(aws_iam_user.this[0].unique_id, "")
}

output "iam_user_login_profile_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the password"
  value       = try(aws_iam_user_login_profile.this[0].key_fingerprint, "")
}

output "iam_user_login_profile_encrypted_password" {
  description = "The encrypted password, base64 encoded"
  value       = try(aws_iam_user_login_profile.this[0].encrypted_password, "")
}

output "iam_user_login_profile_password" {
  description = "The user password"
  value       = lookup(try(aws_iam_user_login_profile.this[0], {}), "password", sensitive(""))
  sensitive   = true
}

output "iam_access_key_id" {
  description = "The access key ID"
  value       = try(aws_iam_access_key.this[0].id, aws_iam_access_key.this_no_pgp[0].id, "")
}

output "iam_access_key_secret" {
  description = "The access key secret"
  value       = try(aws_iam_access_key.this_no_pgp[0].secret, "")
  sensitive   = true
}

output "iam_access_key_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the secret"
  value       = try(aws_iam_access_key.this[0].key_fingerprint, "")
}

output "iam_access_key_encrypted_secret" {
  description = "The encrypted secret, base64 encoded"
  value       = try(aws_iam_access_key.this[0].encrypted_secret, "")
}

output "iam_access_key_ses_smtp_password_v4" {
  description = "The secret access key converted into an SES SMTP password by applying AWS's Sigv4 conversion algorithm"
  value       = try(aws_iam_access_key.this[0].ses_smtp_password_v4, aws_iam_access_key.this_no_pgp[0].ses_smtp_password_v4, "")
  sensitive   = true
}

output "iam_access_key_status" {
  description = "Active or Inactive. Keys are initially active, but can be made inactive by other means."
  value       = try(aws_iam_access_key.this[0].status, aws_iam_access_key.this_no_pgp[0].status, "")
}

output "pgp_key" {
  description = "PGP key used to encrypt sensitive data for this user (if empty - secrets are not encrypted)"
  value       = var.pgp_key
}

output "keybase_password_decrypt_command" {
  description = "Decrypt user password command"
  value       = !local.has_encrypted_password ? null : <<EOF
echo "${try(aws_iam_user_login_profile.this[0].encrypted_password, "")}" | base64 --decode | keybase pgp decrypt
EOF

}

output "keybase_password_pgp_message" {
  description = "Encrypted password"
  value       = !local.has_encrypted_password ? null : <<EOF
-----BEGIN PGP MESSAGE-----
Version: Keybase OpenPGP v2.0.76
Comment: https://keybase.io/crypto

${try(aws_iam_user_login_profile.this[0].encrypted_password, "")}
-----END PGP MESSAGE-----
EOF

}

output "keybase_secret_key_decrypt_command" {
  description = "Decrypt access secret key command"
  value       = !local.has_encrypted_secret ? null : <<EOF
echo "${try(aws_iam_access_key.this[0].encrypted_secret, "")}" | base64 --decode | keybase pgp decrypt
EOF

}

output "keybase_secret_key_pgp_message" {
  description = "Encrypted access secret key"
  value       = !local.has_encrypted_secret ? null : <<EOF
-----BEGIN PGP MESSAGE-----
Version: Keybase OpenPGP v2.0.76
Comment: https://keybase.io/crypto

${try(aws_iam_access_key.this[0].encrypted_secret, "")}
-----END PGP MESSAGE-----
EOF

}

output "iam_user_ssh_key_ssh_public_key_id" {
  description = "The unique identifier for the SSH public key"
  value       = try(aws_iam_user_ssh_key.this[0].ssh_public_key_id, "")
}

output "iam_user_ssh_key_fingerprint" {
  description = "The MD5 message digest of the SSH public key"
  value       = try(aws_iam_user_ssh_key.this[0].fingerprint, "")
}
