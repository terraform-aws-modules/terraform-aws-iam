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
  default     = ""
}

variable "use_name_prefix" {
  description = "Determines whether the IAM role/policy name (`name`/`policy_name`) is used as a prefix"
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

variable "trust_condition_test" {
  description = "Name of the [IAM condition operator](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_condition_operators.html) to evaluate when assuming the role"
  type        = string
  default     = "StringEquals"
}

variable "oidc_providers" {
  description = "Map of OIDC providers where each provider map should contain the `provider`, `provider_arn`, and `namespace_service_accounts`"
  type        = any
  default     = {}
}

variable "policies" {
  description = "Policies to attach to the IAM role in `{'static_name' = 'policy_arn'}` format"
  type        = map(string)
  default     = {}
}

################################################################################
# IAM Policy
################################################################################

variable "create_policy" {
  description = "Whether to create an IAM policy that is attached to the IAM role created"
  type        = bool
  default     = true
}

variable "source_policy_documents" {
  description = "List of IAM policy documents that are merged together into the exported document. Statements must have unique `sid`s"
  type        = list(string)
  default     = []
}

variable "override_policy_documents" {
  description = "List of IAM policy documents that are merged together into the exported document. In merging, statements with non-blank `sid`s will override statements with the same `sid`"
  type        = list(string)
  default     = []
}

variable "permissions" {
  description = "A map of IAM policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) for custom permission usage"
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

variable "policy_path" {
  description = "Path of IAM policy"
  type        = string
  default     = null
}

variable "policy_description" {
  description = "IAM policy description"
  type        = string
  default     = null
}

################################################################################
# Policies
################################################################################

# AWS Gateway Controller
variable "attach_aws_gateway_controller_policy" {
  description = "Determines whether to attach the AWS Gateway Controller IAM policy to the role"
  type        = bool
  default     = false
}

# Cert Manager
variable "attach_cert_manager_policy" {
  description = "Determines whether to attach the Cert Manager IAM policy to the role"
  type        = bool
  default     = false
}

variable "cert_manager_hosted_zone_arns" {
  description = "Route53 hosted zone ARNs to allow Cert manager to manage records"
  type        = list(string)
  default     = []
}

# Cluster autoscaler
variable "attach_cluster_autoscaler_policy" {
  description = "Determines whether to attach the Cluster Autoscaler IAM policy to the role"
  type        = bool
  default     = false
}

variable "cluster_autoscaler_cluster_names" {
  description = "List of cluster names to appropriately scope permissions within the Cluster Autoscaler IAM policy"
  type        = list(string)
  default     = []
}

# EBS CSI
variable "attach_ebs_csi_policy" {
  description = "Determines whether to attach the EBS CSI IAM policy to the role"
  type        = bool
  default     = false
}

variable "ebs_csi_kms_cmk_arns" {
  description = "KMS CMK ARNs to allow EBS CSI to manage encrypted volumes"
  type        = list(string)
  default     = []
}

# S3 CSI
variable "attach_mountpoint_s3_csi_policy" {
  description = "Determines whether to attach the Mountpoint S3 CSI IAM policy to the role"
  type        = bool
  default     = false
}

variable "mountpoint_s3_csi_bucket_arns" {
  description = "S3 bucket ARNs to allow Mountpoint S3 CSI to list buckets"
  type        = list(string)
  default     = []
}

variable "mountpoint_s3_csi_kms_arns" {
  description = "KMS Key ARNs to allow Mountpoint S3 CSI driver to download and upload Objects of a S3 bucket using `aws:kms` SSE"
  type        = list(string)
  default     = []
}

variable "mountpoint_s3_csi_path_arns" {
  description = "S3 path ARNs to allow Mountpoint S3 CSI driver to manage items at the provided path(s). This is required if `attach_mountpoint_s3_csi_policy = true`"
  type        = list(string)
  default     = []
}

# EFS CSI
variable "attach_efs_csi_policy" {
  description = "Determines whether to attach the EFS CSI IAM policy to the role"
  type        = bool
  default     = false
}

# External DNS
variable "attach_external_dns_policy" {
  description = "Determines whether to attach the External DNS IAM policy to the role"
  type        = bool
  default     = false
}

variable "external_dns_hosted_zone_arns" {
  description = "Route53 hosted zone ARNs to allow External DNS to manage records"
  type        = list(string)
  default     = []
}

# External Secrets
variable "attach_external_secrets_policy" {
  description = "Determines whether to attach the External Secrets policy to the role"
  type        = bool
  default     = false
}

variable "external_secrets_ssm_parameter_arns" {
  description = "List of Systems Manager Parameter ARNs that contain secrets to mount using External Secrets"
  type        = list(string)
  default     = []
}

variable "external_secrets_secrets_manager_arns" {
  description = "List of Secrets Manager ARNs that contain secrets to mount using External Secrets"
  type        = list(string)
  default     = []
}

variable "external_secrets_kms_key_arns" {
  description = "List of KMS Key ARNs that are used by Secrets Manager that contain secrets to mount using External Secrets"
  type        = list(string)
  default     = []
}

variable "external_secrets_secrets_manager_create_permission" {
  description = "Determines whether External Secrets may use secretsmanager:CreateSecret"
  type        = bool
  default     = false
}

# FSx Lustre CSI
variable "attach_fsx_lustre_csi_policy" {
  description = "Determines whether to attach the FSx for Lustre CSI Driver IAM policy to the role"
  type        = bool
  default     = false
}

variable "fsx_lustre_csi_service_role_arns" {
  description = "Service role ARNs to allow FSx for Lustre CSI create and manage FSX for Lustre service linked roles"
  type        = list(string)
  default     = ["arn:aws:iam::*:role/aws-service-role/s3.data-source.lustre.fsx.amazonaws.com/*"]
}

# FSx OpenZFS CSI
variable "attach_fsx_openzfs_csi_policy" {
  description = "Determines whether to attach the FSx for OpenZFS CSI Driver IAM policy to the role"
  type        = bool
  default     = false
}

variable "fsx_openzfs_csi_service_role_arns" {
  description = "Service role ARNs to allow FSx for OpenZFS CSI create and manage FSX for openzfs service linked roles"
  type        = list(string)
  default     = ["arn:aws:iam::*:role/aws-service-role/fsx.amazonaws.com/*"]
}

# AWS Load Balancer Controller
variable "attach_load_balancer_controller_policy" {
  description = "Determines whether to attach the Load Balancer Controller policy to the role"
  type        = bool
  default     = false
}

# https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/guide/targetgroupbinding/targetgroupbinding/#reference
# https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/deploy/installation/#setup-iam-manually
variable "attach_load_balancer_controller_targetgroup_binding_only_policy" {
  description = "Determines whether to attach the Load Balancer Controller policy for the TargetGroupBinding only"
  type        = bool
  default     = false
}

variable "load_balancer_controller_targetgroup_arns" {
  description = "List of Target groups ARNs using Load Balancer Controller"
  type        = list(string)
  default     = []
}

# Amazon Managed Service for Prometheus
variable "attach_amazon_managed_service_prometheus_policy" {
  description = "Determines whether to attach the Amazon Managed Service for Prometheus IAM policy to the role"
  type        = bool
  default     = false
}

variable "amazon_managed_service_prometheus_workspace_arns" {
  description = "List of AMP Workspace ARNs to read and write metrics"
  type        = list(string)
  default     = []
}

# Velero
variable "attach_velero_policy" {
  description = "Determines whether to attach the Velero IAM policy to the role"
  type        = bool
  default     = false
}

variable "velero_s3_bucket_arns" {
  description = "List of S3 Bucket ARNs that Velero needs access to in order to backup and restore cluster resources"
  type        = list(string)
  default     = []
}

# VPC CNI
variable "attach_vpc_cni_policy" {
  description = "Determines whether to attach the VPC CNI IAM policy to the role"
  type        = bool
  default     = false
}

variable "vpc_cni_enable_cloudwatch_logs" {
  description = "Determines whether to enable VPC CNI permission to create CloudWatch Log groups and publish network policy events"
  type        = bool
  default     = false
}

variable "vpc_cni_enable_ipv4" {
  description = "Determines whether to enable IPv4 permissions for VPC CNI policy"
  type        = bool
  default     = false
}

variable "vpc_cni_enable_ipv6" {
  description = "Determines whether to enable IPv6 permissions for VPC CNI policy"
  type        = bool
  default     = false
}

# Node termination handler
variable "attach_node_termination_handler_policy" {
  description = "Determines whether to attach the Node Termination Handler policy to the role"
  type        = bool
  default     = false
}

variable "node_termination_handler_sqs_queue_arns" {
  description = "List of SQS ARNs that contain node termination events"
  type        = list(string)
  default     = []
}

# Amazon CloudWatch Observability
variable "attach_cloudwatch_observability_policy" {
  description = "Determines whether to attach the Amazon CloudWatch Observability IAM policies to the role"
  type        = bool
  default     = false
}

################################################################################
# IAM Role Inline policy
################################################################################

variable "create_inline_policy" {
  description = "Determines whether to create an inline policy"
  type        = bool
  default     = false
}

variable "source_inline_policy_documents" {
  description = "List of IAM policy documents that are merged together into the exported document. Statements must have unique `sid`s"
  type        = list(string)
  default     = []
}

variable "override_inline_policy_documents" {
  description = "List of IAM policy documents that are merged together into the exported document. In merging, statements with non-blank `sid`s will override statements with the same `sid`"
  type        = list(string)
  default     = []
}

variable "inline_policy_permissions" {
  description = "A map of IAM policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) for inline policy permissions"
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
