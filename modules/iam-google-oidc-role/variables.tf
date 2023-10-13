variable "create" {
  description = "Controls if resources should be created (affects all resources)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to the resources created"
  type        = map(any)
  default     = {}
}

################################################################################
# Google OIDC Role
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

variable "force_detach_policies" {
  description = "Whether policies should be detached from this role when destroying"
  type        = bool
  default     = true
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = number
  default     = null
}

variable "role_policy_arns" {
  description = "List of ARNs of IAM policies to attach to IAM role"
  type        = list(string)
  default     = []
}

variable "google_service_account_ids" {
  description = "Must be the google service account IDs (not email address). This is used for both subjects"
  type        = list(string)
  default     = []
}

variable "google_service_account_emails" {
  description = "Must be the google service account email address."
  type        = list(string)
  default     = []
}

variable "provider_url" {
  description = "The URL of the identity provider. Corresponds to the iss claim"
  type        = string
  default     = "accounts.google.com"
}
