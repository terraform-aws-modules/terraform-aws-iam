variable "create" {
  description = "Controls if resources should be created (affects all resources)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# IAM Group
################################################################################

variable "name" {
  description = "The group's name. The name must consist of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: `=,.@-_.`"
  type        = string
  default     = ""
}

variable "path" {
  description = "Path in which to create the group"
  type        = string
  default     = null
}

variable "users" {
  description = "A list of IAM User names to associate with the Group"
  type        = list(string)
  default     = []
}

################################################################################
# IAM Group Policy
################################################################################

variable "create_policy" {
  description = "Whether to create IAM policy for IAM group"
  type        = bool
  default     = true
}

variable "enable_self_management_permissions" {
  description = "Determines whether permissions are added to the policy which allow the groups IAM users to manage their credentials and MFA"
  type        = bool
  default     = true
}

variable "enable_mfa_enforcment" {
  description = "Determines whether permissions are added to the policy which requires the groups IAM users to use MFA"
  type        = bool
  default     = true
}

variable "permission_statements" {
  description = "List of IAM policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) for the policy"
  type        = any
  default     = []
}

variable "policy_name_prefix" {
  description = "Name prefix for IAM policy"
  type        = string
  default     = null
}

variable "policy_description" {
  description = "Description of the IAM policy"
  type        = string
  default     = null
}

variable "policy_path" {
  description = "The IAM policy path"
  type        = string
  default     = null
}

variable "policies" {
  description = "Policies to attach to the IAM role in `{'static_name' = 'policy_arn'}` format"
  type        = map(string)
  default     = {}
}

variable "users_account_id" {
  description = "An overriding AWS account ID where the group's users reside; leave empty to use the current account ID for the AWS provider"
  type        = string
  default     = null
}
