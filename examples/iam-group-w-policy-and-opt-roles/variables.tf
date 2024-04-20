variable "assumable_roles" {
  type        = list(string)
  description = "List of ARNS for roles assumable by this group"
  default     = []
}
