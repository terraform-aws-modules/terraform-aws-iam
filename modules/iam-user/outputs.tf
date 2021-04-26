locals {
  has_encrypted_password = length(compact(aws_iam_user_login_profile.this.*.encrypted_password)) > 0
  has_encrypted_secret   = length(compact(aws_iam_access_key.this.*.encrypted_secret)) > 0
}

output "iam_user_name" {
  description = "The user's name"
  value       = element(concat(aws_iam_user.this.*.name, [""]), 0)
}

output "iam_user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = element(concat(aws_iam_user.this.*.arn, [""]), 0)
}

output "iam_user_unique_id" {
  description = "The unique ID assigned by AWS"
  value       = element(concat(aws_iam_user.this.*.unique_id, [""]), 0)
}

output "iam_user_login_profile_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the password"
  value       = element(concat(aws_iam_user_login_profile.this.*.key_fingerprint, [""]), 0)
}

output "iam_user_login_profile_encrypted_password" {
  description = "The encrypted password, base64 encoded"
  value       = element(concat(aws_iam_user_login_profile.this.*.encrypted_password, [""]), 0)
}

output "iam_access_key_id" {
  description = "The access key ID"
  value = element(
    concat(
      aws_iam_access_key.this.*.id,
      aws_iam_access_key.this_no_pgp.*.id,
      [""],
    ),
    0
  )
}

output "iam_access_key_secret" {
  description = "The access key secret"
  value       = element(concat(aws_iam_access_key.this_no_pgp.*.secret, [""]), 0)
  sensitive   = true
}

output "iam_access_key_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the secret"
  value       = element(concat(aws_iam_access_key.this.*.key_fingerprint, [""]), 0)
}

output "iam_access_key_encrypted_secret" {
  description = "The encrypted secret, base64 encoded"
  value       = element(concat(aws_iam_access_key.this.*.encrypted_secret, [""]), 0)
}

output "iam_access_key_ses_smtp_password_v4" {
  description = "The secret access key converted into an SES SMTP password by applying AWS's Sigv4 conversion algorithm"
  value = element(
    concat(
      aws_iam_access_key.this.*.ses_smtp_password_v4,
      aws_iam_access_key.this_no_pgp.*.ses_smtp_password_v4,
      [""],
    ),
    0
  )
  sensitive = true
}

output "iam_access_key_status" {
  description = "Active or Inactive. Keys are initially active, but can be made inactive by other means."
  value = element(
    concat(
      aws_iam_access_key.this.*.status,
      aws_iam_access_key.this_no_pgp.*.status,
      [""],
    ),
    0
  )
}

output "pgp_key" {
  description = "PGP key used to encrypt sensitive data for this user (if empty - secrets are not encrypted)"
  value       = var.pgp_key
}

output "keybase_password_decrypt_command" {
  description = "Decrypt user password command"
  value       = !local.has_encrypted_password ? null : <<EOF
echo "${element(concat(aws_iam_user_login_profile.this.*.encrypted_password, [""]), 0)}" | base64 --decode | keybase pgp decrypt
EOF

}

output "keybase_password_pgp_message" {
  description = "Encrypted password"
  value       = !local.has_encrypted_password ? null : <<EOF
-----BEGIN PGP MESSAGE-----
Version: Keybase OpenPGP v2.0.76
Comment: https://keybase.io/crypto

${element(concat(aws_iam_user_login_profile.this.*.encrypted_password, [""]), 0)}
-----END PGP MESSAGE-----
EOF

}

output "keybase_secret_key_decrypt_command" {
  description = "Decrypt access secret key command"
  value       = !local.has_encrypted_secret ? null : <<EOF
echo "${element(concat(aws_iam_access_key.this.*.encrypted_secret, [""]), 0)}" | base64 --decode | keybase pgp decrypt
EOF

}

output "keybase_secret_key_pgp_message" {
  description = "Encrypted access secret key"
  value       = !local.has_encrypted_secret ? null : <<EOF
-----BEGIN PGP MESSAGE-----
Version: Keybase OpenPGP v2.0.76
Comment: https://keybase.io/crypto

${element(concat(aws_iam_access_key.this.*.encrypted_secret, [""]), 0)}
-----END PGP MESSAGE-----
EOF

}

output "iam_user_ssh_key_ssh_public_key_id" {
  description = "The unique identifier for the SSH public key"
  value       = element(concat(aws_iam_user_ssh_key.this.*.ssh_public_key_id, [""]), 0)
}

output "iam_user_ssh_key_fingerprint" {
  description = "The MD5 message digest of the SSH public key"
  value       = element(concat(aws_iam_user_ssh_key.this.*.fingerprint, [""]), 0)
}
