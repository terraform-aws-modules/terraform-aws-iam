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
# IAM Policy
################################################################################

variable "create_policy" {
  description = "Controls if IAM policy should be created. Set to `false` to generate the policy JSON without creating the policy itself"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name to use on IAM policy created"
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "Name prefix to use on IAM policy created"
  type        = string
  default     = null
}

variable "path" {
  description = "Path of IAM policy"
  type        = string
  default     = "/"
}

variable "description" {
  description = "The description of the policy"
  type        = string
  default     = "IAM Policy"
}

variable "allowed_services" {
  description = "List of services to allow Get/List/Describe/View options. Service name should be the same as corresponding service IAM prefix. See what it is for each service here https://docs.aws.amazon.com/service-authorization/latest/reference/reference_policies_actions-resources-contextkeys.html"
  type        = list(string)
  default     = []
}

variable "additional_policy_json" {
  description = "JSON policy document if you want to add custom actions"
  type        = string
  default     = ""
}

variable "allow_cloudwatch_logs_query" {
  description = "Allows StartQuery/StopQuery/FilterLogEvents CloudWatch actions"
  type        = bool
  default     = true
}

variable "allow_predefined_sts_actions" {
  description = "Allows GetCallerIdentity/GetSessionToken/GetAccessKeyInfo sts actions"
  type        = bool
  default     = true
}

variable "allow_web_console_services" {
  description = "Allows List/Get/Describe/View actions for services used when browsing AWS console (e.g. resource-groups, tag, health services)"
  type        = bool
  default     = true
}

variable "web_console_services" {
  description = "List of web console services to allow"
  type        = list(string)
  default     = ["resource-groups", "tag", "health", "ce"]
}
