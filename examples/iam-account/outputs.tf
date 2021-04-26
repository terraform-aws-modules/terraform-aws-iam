output "caller_identity_account_id" {
  description = "The ID of the AWS account"
  value       = module.iam_account.caller_identity_account_id
}

output "iam_account_password_policy_expire_passwords" {
  description = "Indicates whether passwords in the account expire. Returns true if max_password_age contains a value greater than 0. Returns false if it is 0 or not present."
  value       = module.iam_account.iam_account_password_policy_expire_passwords
}
