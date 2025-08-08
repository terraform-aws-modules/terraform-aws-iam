output "iam_account_password_policy_expire_passwords" {
  description = "Indicates whether passwords in the account expire. Returns true if max_password_age contains a value greater than 0. Returns false if it is 0 or not present"
  value       = try(aws_iam_account_password_policy.this[0].expire_passwords, null)
}
