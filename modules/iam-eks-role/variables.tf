variable "create_role" {
  description = "Whether to create a role"
  type        = bool
  default     = true
}

variable "role_name" {
  description = "Name of IAM role"
  type        = string
  default     = null
}

variable "role_path" {
  description = "Path of IAM role"
  type        = string
  default     = "/"
}

variable "role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for IAM role"
  type        = string
  default     = ""
}

variable "role_description" {
  description = "IAM Role description"
  type        = string
  default     = ""
}

variable "role_name_prefix" {
  description = "IAM role name prefix"
  type        = string
  default     = null
}

variable "role_policy_arns" {
  description = "ARNs of any policies to attach to the IAM role"
  type        = list(string)
  default     = []
}

variable "cluster_service_accounts" {
  description = "EKS cluster and k8s ServiceAccount pairs. Each EKS cluster can have multiple k8s ServiceAccount. See README for details"
  type        = map(list(string))
  default     = {}
}

variable "provider_url_sa_pairs" {
  description = "OIDC provider URL and k8s ServiceAccount pairs. If the assume role policy requires a mix of EKS clusters and other OIDC providers then this can be used"
  type        = map(list(string))
  default     = {}
}

variable "tags" {
  description = "A map of tags to add the the IAM role"
  type        = map(any)
  default     = {}
}

variable "force_detach_policies" {
  description = "Whether policies should be detached from this role when destroying"
  type        = bool
  default     = false
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = number
  default     = 43200
}

################################################################################
# Policies
################################################################################

# Cluster autoscaler
variable "attach_cluster_autoscaler_policy" {
  description = "Whether to attach the Cluster Autoscaler IAM policy to the role"
  type        = bool
  default     = false
}

# External DNS
variable "attach_external_dns_policy" {
  description = "Whether to attach the External DNS IAM policy to the role"
  type        = bool
  default     = false
}

variable "external_dns_hosted_zones" {
  description = "Route53 hosted zone IDs to allow external DNS to manage records"
  type        = list(string)
  default     = ["*"]
}

# EBS CSI
variable "attach_ebs_csi_policy" {
  description = "Whether to attach the EBS CSI IAM policy to the role"
  type        = bool
  default     = false
}

variable "ebs_csi_kms_cmk_ids" {
  description = "KMS CMK IDs to allow EBS CSI to manage encrypted volumes"
  type        = list(string)
  default     = []
}
