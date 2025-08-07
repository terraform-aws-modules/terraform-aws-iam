output "caller_identity_account_id" {
  description = "The AWS Account ID number of the account that owns or contains the calling entity"
  value       = try(data.aws_caller_identity.this[0].account_id, null)
}

output "caller_identity_arn" {
  description = "The AWS ARN associated with the calling entity"
  value       = try(data.aws_caller_identity.this[0].arn, null)
}

output "caller_identity_user_id" {
  description = "The unique identifier of the calling entity"
  value       = try(data.aws_caller_identity.this[0].user_id, null)
}

output "iam_account_password_policy_expire_passwords" {
  description = "Indicates whether passwords in the account expire. Returns true if max_password_age contains a value greater than 0. Returns false if it is 0 or not present"
  value       = try(aws_iam_account_password_policy.this[0].expire_passwords, null)
}
