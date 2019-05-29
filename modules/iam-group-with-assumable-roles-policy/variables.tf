variable "name" {
  description = "Name of IAM policy and IAM group"
}

variable "assumable_roles" {
  description = "List of IAM roles ARNs which can be assumed by the group"
  default     = []
}

variable "group_users" {
  description = "List of IAM users to have in an IAM group which can assume the role"
  default     = []
}

