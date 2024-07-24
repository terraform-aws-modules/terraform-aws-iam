variable "create" {
  description = "Controls if resources should be created (affects all resources)"
  type        = bool
  default     = true
  nullable    = false
}

variable "tags" {
  description = "A map of tags to add to the resources created"
  type        = map(any)
  default     = {}
  nullable    = false
}

################################################################################
# CircelCI OIDC Role
################################################################################

variable "name" {
  description = "Name of IAM role"
  type        = string
  default     = null
}

variable "path" {
  description = "Path of IAM role"
  type        = string
  default     = "/"
  nullable    = false
}

variable "permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for IAM role"
  type        = string
  default     = null
}

variable "description" {
  description = "IAM Role description"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "IAM role name prefix"
  type        = string
  default     = null
}

variable "policies" {
  description = "Policies to attach to the IAM role in `{'static_name' = 'policy_arn'}` format"
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "force_detach_policies" {
  description = "Whether policies should be detached from this role when destroying"
  type        = bool
  default     = true
  nullable    = false
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = number
  default     = null
}

variable "project_uuids" {
  description = "List of CircleCI project UUIDs that are permitted by the trust policy"
  type        = list(string)
  default     = []
}

variable "oidc_provider_arn" {
  description = "The URL of the identity provider"
  type        = string
}

variable "org_uuid" {
  description = "The CircleCI organization UUID that will be authorized to assume the role."
  type        = string
  nullable    = false
}

variable "base_url" {
  description = "The URL of the identity provider. Corresponds to the iss claim"
  type        = string
  default     = "https://oidc.circleci.com/org"
  nullable    = false
}
