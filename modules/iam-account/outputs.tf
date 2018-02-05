output "this_caller_identity_account_id" {
  description = "The AWS Account ID number of the account that owns or contains the calling entity"
  value       = "${element(concat(data.aws_caller_identity.this.*.account_id, list("")), 0)}"
}

output "this_caller_identity_arn" {
  description = "The AWS ARN associated with the calling entity"
  value       = "${element(concat(data.aws_caller_identity.this.*.arn, list("")), 0)}"
}

output "this_caller_identity_user_id" {
  description = "The unique identifier of the calling entity"
  value       = "${element(concat(data.aws_caller_identity.this.*.user_id, list("")), 0)}"
}

output "this_iam_account_password_policy_expire_passwords" {
  description = "Indicates whether passwords in the account expire. Returns true if max_password_age contains a value greater than 0. Returns false if it is 0 or not present."
  value       = "${element(concat(aws_iam_account_password_policy.this.*.expire_passwords, list("")), 0)}"
}
