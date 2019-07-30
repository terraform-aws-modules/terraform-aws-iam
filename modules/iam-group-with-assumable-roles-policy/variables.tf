variable "group_name" {
  description = "Name of IAM group"
  type        = string
}

variable "group_path" {
  description = "Group path"
  type        = string
  default     = "/"
}

variable "policy_name" {
  description = "Name of IAM policy"
  type        = string
}

variable "policy_path" {
  description = "Policy path"
  type        = string
  default     = "/"
}

variable "assumable_roles" {
  description = "List of IAM roles ARNs which can be assumed by the group"
  type        = list(string)
  default     = []
}

variable "group_users" {
  description = "List of IAM users to have in an IAM group which can assume the role"
  type        = list(string)
  default     = []
}

