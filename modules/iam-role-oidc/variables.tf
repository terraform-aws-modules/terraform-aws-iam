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
# IAM Role
################################################################################

variable "name" {
  description = "Name to use on IAM role created"
  type        = string
  default     = null
}

variable "use_name_prefix" {
  description = "Determines whether the IAM role name (`name`) is used as a prefix"
  type        = bool
  default     = true
}

variable "path" {
  description = "Path of IAM role"
  type        = string
  default     = "/"
}

variable "description" {
  description = "Description of the role"
  type        = string
  default     = null
}

variable "max_session_duration" {
  description = "Maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours"
  type        = number
  default     = null
}

variable "permissions_boundary" {
  description = "ARN of the policy that is used to set the permissions boundary for the IAM role"
  type        = string
  default     = null
}

variable "assume_role_policy_statements" {
  description = "List of IAM policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) for for trusted assume role policy"
  type = list(object({
    sid           = optional(string)
    actions       = optional(list(string))
    not_actions   = optional(list(string))
    effect        = optional(string)
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
      values   = list(string)
      variable = string
    })))
  }))
  default = null
}

variable "policies" {
  description = "Policies to attach to the IAM role in `{'static_name' = 'policy_arn'}` format"
  type        = map(string)
  default     = {}
}

variable "oidc_account_id" {
  description = "An overriding AWS account ID where the OIDC provider lives; leave empty to use the current account ID for the AWS provider"
  type        = string
  default     = null
}

variable "oidc_provider_urls" {
  description = "List of URLs of the OIDC Providers"
  type        = list(string)
  default     = []
}

variable "oidc_subjects" {
  description = "The fully qualified OIDC subjects to be added to the role policy"
  type        = set(string)
  default     = []
}

variable "oidc_wildcard_subjects" {
  description = "The OIDC subject using wildcards to be added to the role policy"
  type        = set(string)
  default     = []
}

variable "oidc_audiences" {
  description = "The audience to be added to the role policy. Set to sts.amazonaws.com for cross-account assumable role. Leave empty otherwise."
  type        = set(string)
  default     = []
}

variable "enable_github_oidc" {
  description = "Enable GitHub OIDC provider trust for the role"
  type        = bool
  default     = false
}

variable "enable_bitbucket_oidc" {
  description = "Enable Bitbucket OIDC provider trust for the role"
  type        = bool
  default     = false
}
