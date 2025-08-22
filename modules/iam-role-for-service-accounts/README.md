# AWS IAM Role for EKS Service Accounts Terraform Module

> [!TIP]
> Upgrade to use EKS Pod Identity instead of IRSA
> A similar module for EKS Pod Identity is available [here](https://github.com/terraform-aws-modules/terraform-aws-eks-pod-identity).

> [!IMPORTANT]
> The [karpenter](https://github.com/terraform-aws-modules/terraform-aws-eks/tree/master/modules/karpenter) sub-module contains the necessary AWS resources for running Karpenter, including the Karpenter controller IAM role & policy

Creates an IAM role which can be assumed by AWS EKS `ServiceAccount`s with optional policies for commonly used controllers/custom resources within EKS. The optional policies supported include:
- [Cert-Manager](https://cert-manager.io/docs/configuration/acme/dns01/route53/#set-up-an-iam-role)
- [Cluster Autoscaler](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/aws/README.md)
- [EBS CSI Driver](https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/master/docs/example-iam-policy.json)
- [EFS CSI Driver](https://github.com/kubernetes-sigs/aws-efs-csi-driver/blob/master/docs/iam-policy-example.json)
- [External DNS](https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/aws.md#iam-policy)
- [External Secrets](https://github.com/external-secrets/external-secrets#add-a-secret)
- [FSx for Lustre CSI Driver](https://github.com/kubernetes-sigs/aws-fsx-csi-driver/blob/master/docs/README.md)
- [FSx for OpenZFS CSI Driver](https://github.com/kubernetes-sigs/aws-fsx-openzfs-csi-driver/blob/main/README.md)
- [Karpenter](https://github.com/aws/karpenter/blob/main/website/content/en/preview/getting-started/getting-started-with-karpenter/cloudformation.yaml)
- [Load Balancer Controller](https://github.com/kubernetes-sigs/aws-load-balancer-controller/blob/main/docs/install/iam_policy.json)
  - [Load Balancer Controller Target Group Binding Only](https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.4/deploy/installation/#iam-permission-subset-for-those-who-use-targetgroupbinding-only-and-dont-plan-to-use-the-aws-load-balancer-controller-to-manage-security-group-rules)
- [Managed Service for Prometheus](https://docs.aws.amazon.com/prometheus/latest/userguide/set-up-irsa.html)
- [Mountpoint S3 CSI Driver](https://github.com/awslabs/mountpoint-s3/blob/main/doc/CONFIGURATION.md#iam-permissions)
- [Node Termination Handler](https://github.com/aws/aws-node-termination-handler#5-create-an-iam-role-for-the-pods)
- [Velero](https://github.com/vmware-tanzu/velero-plugin-for-aws#option-1-set-permissions-with-an-iam-user)
- [VPC CNI](https://docs.aws.amazon.com/eks/latest/userguide/cni-iam-role.html)
This module is intended to be used with AWS EKS. For details of how a `ServiceAccount` in EKS can assume an IAM role, see the [EKS documentation](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html).

This module supports multiple `ServiceAccount`s across multiple clusters and/or namespaces. This allows for a single IAM role to be used when an application may span multiple clusters (e.g. for DR) or multiple namespaces (e.g. for canary deployments). For example, to create an IAM role named `my-app` that can be assumed from the `ServiceAccount` named `my-app-staging` in the namespace `default` and `canary` in a cluster in `us-east-1`; and also the `ServiceAccount` name `my-app-staging` in the namespace `default` in a cluster in `ap-southeast-1`, the configuration would be:

## Usage

```hcl
module "irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts"

  name = "my-app"

  oidc_providers = {
    one = {
      provider_arn               = "arn:aws:iam::012345678901:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/5C54DDF35ER19312844C7333374CC09D"
      namespace_service_accounts = ["default:my-app-staging", "canary:my-app-staging"]
    }
    two = {
      provider_arn               = "arn:aws:iam::012345678901:oidc-provider/oidc.eks.ap-southeast-1.amazonaws.com/id/5C54DDF35ER54476848E7333374FF09G"
      namespace_service_accounts = ["default:my-app-staging"]
    }
  }

  policies = {
    policy = "arn:aws:iam::012345678901:policy/myapp"
  }
}
```

This module has been designed in conjunction with the [`terraform-aws-eks`](https://github.com/terraform-aws-modules/terraform-aws-eks) module to easily integrate with it:

```hcl
module "ebs_csi_driver_irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts"

  name = "ebs-csi"

  attach_ebs_csi_policy = true

  oidc_providers = {
    this = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "my-cluster"
  kubernetes_version = "1.33"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  addons = {
    coredns = {}
    aws-ebs-csi-driver = {
      service_account_role_arn = module.ebs_csi_driver_irsa.arn
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
  }

  eks_managed_node_groups = {
    example = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["m5.xlarge"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.inline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.amazon_cloudwatch_observability](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.amazon_managed_service_prometheus](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.aws_gateway_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cert_manager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ebs_csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.efs_csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.external_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.fsx_lustre_csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.fsx_openzfs_csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.inline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.load_balancer_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.load_balancer_controller_targetgroup_only](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.mountpoint_s3_csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.node_termination_handler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.velero](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_amazon_managed_service_prometheus_workspace_arns"></a> [amazon\_managed\_service\_prometheus\_workspace\_arns](#input\_amazon\_managed\_service\_prometheus\_workspace\_arns) | List of AMP Workspace ARNs to read and write metrics | `list(string)` | `[]` | no |
| <a name="input_attach_amazon_managed_service_prometheus_policy"></a> [attach\_amazon\_managed\_service\_prometheus\_policy](#input\_attach\_amazon\_managed\_service\_prometheus\_policy) | Determines whether to attach the Amazon Managed Service for Prometheus IAM policy to the role | `bool` | `false` | no |
| <a name="input_attach_aws_gateway_controller_policy"></a> [attach\_aws\_gateway\_controller\_policy](#input\_attach\_aws\_gateway\_controller\_policy) | Determines whether to attach the AWS Gateway Controller IAM policy to the role | `bool` | `false` | no |
| <a name="input_attach_cert_manager_policy"></a> [attach\_cert\_manager\_policy](#input\_attach\_cert\_manager\_policy) | Determines whether to attach the Cert Manager IAM policy to the role | `bool` | `false` | no |
| <a name="input_attach_cloudwatch_observability_policy"></a> [attach\_cloudwatch\_observability\_policy](#input\_attach\_cloudwatch\_observability\_policy) | Determines whether to attach the Amazon CloudWatch Observability IAM policies to the role | `bool` | `false` | no |
| <a name="input_attach_cluster_autoscaler_policy"></a> [attach\_cluster\_autoscaler\_policy](#input\_attach\_cluster\_autoscaler\_policy) | Determines whether to attach the Cluster Autoscaler IAM policy to the role | `bool` | `false` | no |
| <a name="input_attach_ebs_csi_policy"></a> [attach\_ebs\_csi\_policy](#input\_attach\_ebs\_csi\_policy) | Determines whether to attach the EBS CSI IAM policy to the role | `bool` | `false` | no |
| <a name="input_attach_efs_csi_policy"></a> [attach\_efs\_csi\_policy](#input\_attach\_efs\_csi\_policy) | Determines whether to attach the EFS CSI IAM policy to the role | `bool` | `false` | no |
| <a name="input_attach_external_dns_policy"></a> [attach\_external\_dns\_policy](#input\_attach\_external\_dns\_policy) | Determines whether to attach the External DNS IAM policy to the role | `bool` | `false` | no |
| <a name="input_attach_external_secrets_policy"></a> [attach\_external\_secrets\_policy](#input\_attach\_external\_secrets\_policy) | Determines whether to attach the External Secrets policy to the role | `bool` | `false` | no |
| <a name="input_attach_fsx_lustre_csi_policy"></a> [attach\_fsx\_lustre\_csi\_policy](#input\_attach\_fsx\_lustre\_csi\_policy) | Determines whether to attach the FSx for Lustre CSI Driver IAM policy to the role | `bool` | `false` | no |
| <a name="input_attach_fsx_openzfs_csi_policy"></a> [attach\_fsx\_openzfs\_csi\_policy](#input\_attach\_fsx\_openzfs\_csi\_policy) | Determines whether to attach the FSx for OpenZFS CSI Driver IAM policy to the role | `bool` | `false` | no |
| <a name="input_attach_load_balancer_controller_policy"></a> [attach\_load\_balancer\_controller\_policy](#input\_attach\_load\_balancer\_controller\_policy) | Determines whether to attach the Load Balancer Controller policy to the role | `bool` | `false` | no |
| <a name="input_attach_load_balancer_controller_targetgroup_binding_only_policy"></a> [attach\_load\_balancer\_controller\_targetgroup\_binding\_only\_policy](#input\_attach\_load\_balancer\_controller\_targetgroup\_binding\_only\_policy) | Determines whether to attach the Load Balancer Controller policy for the TargetGroupBinding only | `bool` | `false` | no |
| <a name="input_attach_mountpoint_s3_csi_policy"></a> [attach\_mountpoint\_s3\_csi\_policy](#input\_attach\_mountpoint\_s3\_csi\_policy) | Determines whether to attach the Mountpoint S3 CSI IAM policy to the role | `bool` | `false` | no |
| <a name="input_attach_node_termination_handler_policy"></a> [attach\_node\_termination\_handler\_policy](#input\_attach\_node\_termination\_handler\_policy) | Determines whether to attach the Node Termination Handler policy to the role | `bool` | `false` | no |
| <a name="input_attach_velero_policy"></a> [attach\_velero\_policy](#input\_attach\_velero\_policy) | Determines whether to attach the Velero IAM policy to the role | `bool` | `false` | no |
| <a name="input_attach_vpc_cni_policy"></a> [attach\_vpc\_cni\_policy](#input\_attach\_vpc\_cni\_policy) | Determines whether to attach the VPC CNI IAM policy to the role | `bool` | `false` | no |
| <a name="input_cert_manager_hosted_zone_arns"></a> [cert\_manager\_hosted\_zone\_arns](#input\_cert\_manager\_hosted\_zone\_arns) | Route53 hosted zone ARNs to allow Cert manager to manage records | `list(string)` | `[]` | no |
| <a name="input_cluster_autoscaler_cluster_names"></a> [cluster\_autoscaler\_cluster\_names](#input\_cluster\_autoscaler\_cluster\_names) | List of cluster names to appropriately scope permissions within the Cluster Autoscaler IAM policy | `list(string)` | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls if resources should be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_inline_policy"></a> [create\_inline\_policy](#input\_create\_inline\_policy) | Determines whether to create an inline policy | `bool` | `false` | no |
| <a name="input_create_policy"></a> [create\_policy](#input\_create\_policy) | Whether to create an IAM policy that is attached to the IAM role created | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the role | `string` | `null` | no |
| <a name="input_ebs_csi_kms_cmk_arns"></a> [ebs\_csi\_kms\_cmk\_arns](#input\_ebs\_csi\_kms\_cmk\_arns) | KMS CMK ARNs to allow EBS CSI to manage encrypted volumes | `list(string)` | `[]` | no |
| <a name="input_external_dns_hosted_zone_arns"></a> [external\_dns\_hosted\_zone\_arns](#input\_external\_dns\_hosted\_zone\_arns) | Route53 hosted zone ARNs to allow External DNS to manage records | `list(string)` | `[]` | no |
| <a name="input_external_secrets_kms_key_arns"></a> [external\_secrets\_kms\_key\_arns](#input\_external\_secrets\_kms\_key\_arns) | List of KMS Key ARNs that are used by Secrets Manager that contain secrets to mount using External Secrets | `list(string)` | `[]` | no |
| <a name="input_external_secrets_secrets_manager_arns"></a> [external\_secrets\_secrets\_manager\_arns](#input\_external\_secrets\_secrets\_manager\_arns) | List of Secrets Manager ARNs that contain secrets to mount using External Secrets | `list(string)` | `[]` | no |
| <a name="input_external_secrets_secrets_manager_create_permission"></a> [external\_secrets\_secrets\_manager\_create\_permission](#input\_external\_secrets\_secrets\_manager\_create\_permission) | Determines whether External Secrets may use secretsmanager:CreateSecret | `bool` | `false` | no |
| <a name="input_external_secrets_ssm_parameter_arns"></a> [external\_secrets\_ssm\_parameter\_arns](#input\_external\_secrets\_ssm\_parameter\_arns) | List of Systems Manager Parameter ARNs that contain secrets to mount using External Secrets | `list(string)` | `[]` | no |
| <a name="input_fsx_lustre_csi_service_role_arns"></a> [fsx\_lustre\_csi\_service\_role\_arns](#input\_fsx\_lustre\_csi\_service\_role\_arns) | Service role ARNs to allow FSx for Lustre CSI create and manage FSX for Lustre service linked roles | `list(string)` | <pre>[<br/>  "arn:aws:iam::*:role/aws-service-role/s3.data-source.lustre.fsx.amazonaws.com/*"<br/>]</pre> | no |
| <a name="input_fsx_openzfs_csi_service_role_arns"></a> [fsx\_openzfs\_csi\_service\_role\_arns](#input\_fsx\_openzfs\_csi\_service\_role\_arns) | Service role ARNs to allow FSx for OpenZFS CSI create and manage FSX for openzfs service linked roles | `list(string)` | <pre>[<br/>  "arn:aws:iam::*:role/aws-service-role/fsx.amazonaws.com/*"<br/>]</pre> | no |
| <a name="input_inline_policy_permissions"></a> [inline\_policy\_permissions](#input\_inline\_policy\_permissions) | A map of IAM policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) for inline policy permissions | <pre>map(object({<br/>    sid           = optional(string)<br/>    actions       = optional(list(string))<br/>    not_actions   = optional(list(string))<br/>    effect        = optional(string, "Allow")<br/>    resources     = optional(list(string))<br/>    not_resources = optional(list(string))<br/>    principals = optional(list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    })))<br/>    not_principals = optional(list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    })))<br/>    condition = optional(list(object({<br/>      test     = string<br/>      variable = string<br/>      values   = list(string)<br/>    })))<br/>  }))</pre> | `null` | no |
| <a name="input_load_balancer_controller_targetgroup_arns"></a> [load\_balancer\_controller\_targetgroup\_arns](#input\_load\_balancer\_controller\_targetgroup\_arns) | List of Target groups ARNs using Load Balancer Controller | `list(string)` | `[]` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours | `number` | `null` | no |
| <a name="input_mountpoint_s3_csi_bucket_arns"></a> [mountpoint\_s3\_csi\_bucket\_arns](#input\_mountpoint\_s3\_csi\_bucket\_arns) | S3 bucket ARNs to allow Mountpoint S3 CSI to list buckets | `list(string)` | `[]` | no |
| <a name="input_mountpoint_s3_csi_kms_arns"></a> [mountpoint\_s3\_csi\_kms\_arns](#input\_mountpoint\_s3\_csi\_kms\_arns) | KMS Key ARNs to allow Mountpoint S3 CSI driver to download and upload Objects of a S3 bucket using `aws:kms` SSE | `list(string)` | `[]` | no |
| <a name="input_mountpoint_s3_csi_path_arns"></a> [mountpoint\_s3\_csi\_path\_arns](#input\_mountpoint\_s3\_csi\_path\_arns) | S3 path ARNs to allow Mountpoint S3 CSI driver to manage items at the provided path(s). This is required if `attach_mountpoint_s3_csi_policy = true` | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to use on IAM role created | `string` | `""` | no |
| <a name="input_node_termination_handler_sqs_queue_arns"></a> [node\_termination\_handler\_sqs\_queue\_arns](#input\_node\_termination\_handler\_sqs\_queue\_arns) | List of SQS ARNs that contain node termination events | `list(string)` | `[]` | no |
| <a name="input_oidc_providers"></a> [oidc\_providers](#input\_oidc\_providers) | Map of OIDC providers where each provider map should contain the `provider`, `provider_arn`, and `namespace_service_accounts` | `any` | `{}` | no |
| <a name="input_override_inline_policy_documents"></a> [override\_inline\_policy\_documents](#input\_override\_inline\_policy\_documents) | List of IAM policy documents that are merged together into the exported document. In merging, statements with non-blank `sid`s will override statements with the same `sid` | `list(string)` | `[]` | no |
| <a name="input_override_policy_documents"></a> [override\_policy\_documents](#input\_override\_policy\_documents) | List of IAM policy documents that are merged together into the exported document. In merging, statements with non-blank `sid`s will override statements with the same `sid` | `list(string)` | `[]` | no |
| <a name="input_path"></a> [path](#input\_path) | Path of IAM role | `string` | `"/"` | no |
| <a name="input_permissions"></a> [permissions](#input\_permissions) | A map of IAM policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) for custom permission usage | <pre>map(object({<br/>    sid           = optional(string)<br/>    actions       = optional(list(string))<br/>    not_actions   = optional(list(string))<br/>    effect        = optional(string, "Allow")<br/>    resources     = optional(list(string))<br/>    not_resources = optional(list(string))<br/>    principals = optional(list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    })))<br/>    not_principals = optional(list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    })))<br/>    condition = optional(list(object({<br/>      test     = string<br/>      variable = string<br/>      values   = list(string)<br/>    })))<br/>  }))</pre> | `null` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | ARN of the policy that is used to set the permissions boundary for the IAM role | `string` | `null` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | Policies to attach to the IAM role in `{'static_name' = 'policy_arn'}` format | `map(string)` | `{}` | no |
| <a name="input_policy_description"></a> [policy\_description](#input\_policy\_description) | IAM policy description | `string` | `null` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Name to use on IAM policy created | `string` | `null` | no |
| <a name="input_policy_path"></a> [policy\_path](#input\_policy\_path) | Path of IAM policy | `string` | `null` | no |
| <a name="input_source_inline_policy_documents"></a> [source\_inline\_policy\_documents](#input\_source\_inline\_policy\_documents) | List of IAM policy documents that are merged together into the exported document. Statements must have unique `sid`s | `list(string)` | `[]` | no |
| <a name="input_source_policy_documents"></a> [source\_policy\_documents](#input\_source\_policy\_documents) | List of IAM policy documents that are merged together into the exported document. Statements must have unique `sid`s | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_trust_condition_test"></a> [trust\_condition\_test](#input\_trust\_condition\_test) | Name of the [IAM condition operator](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_condition_operators.html) to evaluate when assuming the role | `string` | `"StringEquals"` | no |
| <a name="input_use_name_prefix"></a> [use\_name\_prefix](#input\_use\_name\_prefix) | Determines whether the IAM role/policy name (`name`/`policy_name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_velero_s3_bucket_arns"></a> [velero\_s3\_bucket\_arns](#input\_velero\_s3\_bucket\_arns) | List of S3 Bucket ARNs that Velero needs access to in order to backup and restore cluster resources | `list(string)` | `[]` | no |
| <a name="input_vpc_cni_enable_cloudwatch_logs"></a> [vpc\_cni\_enable\_cloudwatch\_logs](#input\_vpc\_cni\_enable\_cloudwatch\_logs) | Determines whether to enable VPC CNI permission to create CloudWatch Log groups and publish network policy events | `bool` | `false` | no |
| <a name="input_vpc_cni_enable_ipv4"></a> [vpc\_cni\_enable\_ipv4](#input\_vpc\_cni\_enable\_ipv4) | Determines whether to enable IPv4 permissions for VPC CNI policy | `bool` | `false` | no |
| <a name="input_vpc_cni_enable_ipv6"></a> [vpc\_cni\_enable\_ipv6](#input\_vpc\_cni\_enable\_ipv6) | Determines whether to enable IPv6 permissions for VPC CNI policy | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of IAM role |
| <a name="output_iam_policy"></a> [iam\_policy](#output\_iam\_policy) | The policy document |
| <a name="output_iam_policy_arn"></a> [iam\_policy\_arn](#output\_iam\_policy\_arn) | The ARN assigned by AWS to this policy |
| <a name="output_name"></a> [name](#output\_name) | Name of IAM role |
| <a name="output_path"></a> [path](#output\_path) | Path of IAM role |
| <a name="output_unique_id"></a> [unique\_id](#output\_unique\_id) | Unique ID of IAM role |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/LICENSE).
