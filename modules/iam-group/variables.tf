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

variable "enable_mfa_enforcement" {
  description = "Determines whether permissions are added to the policy which requires the groups IAM users to use MFA"
  type        = bool
  default     = true
}

variable "permissions" {
  description = "A map of IAM policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) for custom permissions"
  type = map(object({
    sid           = optional(string)
    actions       = optional(list(string))
    not_actions   = optional(list(string))
    effect        = optional(string, "Allow")
    resources     = optional(list(string))
    not_resources = optional(list(string))
    principals = optional(list(object({
      type        = string
      identifiers = list(string)
    })))
    not_principals = optional(list(object({
      type        = string
      identifiers = list(string)
    })))
    condition = optional(list(object({
      test     = string
      variable = string
      values   = list(string)
    })))
  }))
  default = null
}

variable "policy_name" {
  description = "Name to use on IAM policy created"
  type        = string
  default     = null
}

variable "policy_use_name_prefix" {
  description = "Determines whether the IAM policy name (`policy_name`) is used as a prefix"
  type        = bool
  default     = true
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
