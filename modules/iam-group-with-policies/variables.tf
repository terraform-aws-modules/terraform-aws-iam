variable "create_group" {
  description = "Whether to create IAM group"
  default     = true
}

variable "name" {
  description = "Name of IAM group"
  default     = ""
}

variable "group_users" {
  description = "List of IAM users to have in an IAM group which can assume the role"
  default     = []
}

variable "custom_group_policy_arns" {
  description = "List of IAM policies ARNs to attach to IAM group"
  default     = []
}

variable "custom_group_policies" {
  description = "List of maps of inline IAM policies to attach to IAM group. Should have `name` and `policy` keys in each element."
  default     = []
}

variable "attach_iam_self_management_policy" {
  description = "Whether to attach IAM policy which allows IAM users to manage their credentials and MFA"
  default     = true
}

variable "iam_self_management_policy_name_prefix" {
  description = "Name prefix for IAM policy to create with IAM self-management permissions"
  default     = "IAMSelfManagement-"
}

variable "aws_account_id" {
  description = "AWS account id to use inside IAM policies. If empty, current AWS account ID will be used."
  default     = ""
}

