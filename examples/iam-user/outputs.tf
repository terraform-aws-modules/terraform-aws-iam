output "this_iam_user_name" {
  description = "The user's name"
  value       = "${module.iam_user.this_iam_user_name}"
}

output "this_iam_user_arn" {
  description = "The ARN assigned by AWS for this user"
  value       = "${module.iam_user.this_iam_user_arn}"
}

output "this_iam_user_unique_id" {
  description = "The unique ID assigned by AWS"
  value       = "${module.iam_user.this_iam_user_unique_id}"
}

output "this_iam_user_login_profile_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the password"
  value       = "${module.iam_user.this_iam_user_login_profile_key_fingerprint}"
}

output "this_iam_user_login_profile_encrypted_password" {
  description = "The encrypted password, base64 encoded"
  value       = "${module.iam_user.this_iam_user_login_profile_encrypted_password}"
}

output "this_iam_access_key_id" {
  description = "The access key ID"
  value       = "${module.iam_user.this_iam_access_key_id}"
}

output "this_iam_access_key_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the secret"
  value       = "${module.iam_user.this_iam_access_key_key_fingerprint}"
}

output "this_iam_access_key_encrypted_secret" {
  description = "The encrypted secret, base64 encoded"
  value       = "${module.iam_user.this_iam_access_key_encrypted_secret}"
}

output "this_iam_access_key_ses_smtp_password" {
  description = "The secret access key converted into an SES SMTP password"
  value       = "${module.iam_user.this_iam_access_key_ses_smtp_password}"
}

output "this_iam_access_key_status" {
  description = "Active or Inactive. Keys are initially active, but can be made inactive by other means."
  value       = "${module.iam_user.this_iam_access_key_status}"
}

output "pgp_key" {
  description = "PGP key used to encrypt sensitive data for this user (if empty - secrets are not encrypted)"
  value       = "${module.iam_user.pgp_key}"
}

output "keybase_password_decrypt_command" {
  value = "${module.iam_user.keybase_password_decrypt_command}"
}

output "keybase_password_pgp_message" {
  value = "${module.iam_user.keybase_password_pgp_message}"
}

output "keybase_secret_key_decrypt_command" {
  value = "${module.iam_user.keybase_secret_key_decrypt_command}"
}

output "keybase_secret_key_pgp_message" {
  value = "${module.iam_user.keybase_secret_key_pgp_message}"
}
