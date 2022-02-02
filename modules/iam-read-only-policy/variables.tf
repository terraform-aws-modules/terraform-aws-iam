variable "create_policy" {
  description = "Whether to create the IAM policy"
  type        = bool
  default     = true
}

variable "name" {
  description = "The name of the policy"
  type        = string
  default     = ""
}

variable "path" {
  description = "The path of the policy in IAM"
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
}

variable "additional_policy_json" {
  description = "JSON policy document if you want to add custom actions"
  type        = string
  default     = "{}"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
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
