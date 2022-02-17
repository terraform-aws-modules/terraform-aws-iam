# IAM Role for Service Accounts in EKS

Creates an IAM role which can be assumed by AWS EKS `ServiceAccount`s with optional policies for commonly used controllers/custom resources within EKS. The optional policies supported include:
- [Cluster Autoscaler](https://github.com/kubernetes/autoscaler/blob/master/cluster-autoscaler/cloudprovider/aws/README.md)
- [External DNS](https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/aws.md#iam-policy)
- [EBS CSI Driver](https://github.com/kubernetes-sigs/aws-ebs-csi-driver/blob/master/docs/example-iam-policy.json)
- [VPC CNI](https://docs.aws.amazon.com/eks/latest/userguide/cni-iam-role.html)
- [Node Termination Hanlder](https://github.com/aws/aws-node-termination-handler#5-create-an-iam-role-for-the-pods)
- [Karpenter](https://github.com/aws/karpenter/blob/main/website/content/en/preview/getting-started/cloudformation.yaml)
- [Load Balancer Controller](https://github.com/kubernetes-sigs/aws-load-balancer-controller/blob/main/docs/install/iam_policy.json)

This module is intended to be used with AWS EKS. For details of how a `ServiceAccount` in EKS can assume an IAM role, see the [EKS documentation](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html).

This module supports multiple `ServiceAccount`s across multiple clusters and/or namespaces. This allows for a single IAM role to be used when an application may span multiple clusters (e.g. for DR) or multiple namespaces (e.g. for canary deployments). For example, to create an IAM role named `my-app` that can be assumed from the `ServiceAccount` named `my-app-staging` in the namespace `default` and `canary` in a cluster in `us-east-1`; and also the `ServiceAccount` name `my-app-staging` in the namespace `default` in a cluster in `ap-southeast-1`, the configuration would be:

```hcl
module "iam_eks_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  role_name = "my-app"

  oidc_providers = {
    one = {
      provider_arn     = "arn:aws:iam::012345678901:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/5C54DDF35ER19312844C7333374CC09D"
      service_accounts = ["default:my-app-staging", "canary:my-app-staging"]
    }
    two = {
      provider_arn     = "arn:aws:iam::012345678901:oidc-provider/oidc.eks.ap-southeast-1.amazonaws.com/id/5C54DDF35ER54476848E7333374FF09G"
      service_accounts = ["default:my-app-staging"]
    }
  }
}
```

This module has been designed in conjunction with the [`terraform-aws-eks`](https://github.com/terraform-aws-modules/terraform-aws-eks) module to easily integrate with it:

```hcl
module "vpc_cni_irsa_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name = "vpc-cni"

  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv4   = true

  oidc_providers = {
    main = {
      provider_arn     = module.eks.oidc_provider_arn
      service_accounts = ["default:my-app", "canary:my-app"]
    }
  }
}

module "karpenter_irsa_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name                          = "karpenter_controller"
  attach_karpenter_controller_policy = true

  karpenter_controller_cluster_ids        = [module.eks.cluster_id]
  karpenter_controller_node_iam_role_arns = [module.eks.eks_managed_node_groups["default"].iam_role_arn]

  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv4   = true

  oidc_providers = {
    main = {
      provider_arn     = module.eks.oidc_provider_arn
      service_accounts = ["default:my-app", "canary:my-app"]
    }
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.6"

  cluster_name    = "my-cluster"
  cluster_version = "1.21"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    default = {}
  }
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ebs_csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.karpenter_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.load_balancer_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.node_termination_handler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ebs_csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.karpenter_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.load_balancer_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.node_termination_handler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.cluster_autoscaler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ebs_csi](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.external_dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.karpenter_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.load_balancer_controller](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.node_termination_handler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.vpc_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attach_cluster_autoscaler_policy"></a> [attach\_cluster\_autoscaler\_policy](#input\_attach\_cluster\_autoscaler\_policy) | Determines whether to attach the Cluster Autoscaler IAM policy to the role | `bool` | `false` | no |
| <a name="input_attach_ebs_csi_policy"></a> [attach\_ebs\_csi\_policy](#input\_attach\_ebs\_csi\_policy) | Determines whether to attach the EBS CSI IAM policy to the role | `bool` | `false` | no |
| <a name="input_attach_external_dns_policy"></a> [attach\_external\_dns\_policy](#input\_attach\_external\_dns\_policy) | Determines whether to attach the External DNS IAM policy to the role | `bool` | `false` | no |
| <a name="input_attach_karpenter_controller_policy"></a> [attach\_karpenter\_controller\_policy](#input\_attach\_karpenter\_controller\_policy) | Determines whether to attach the Karpenter Controller policy to the role | `bool` | `false` | no |
| <a name="input_attach_load_balancer_controller_policy"></a> [attach\_load\_balancer\_controller\_policy](#input\_attach\_load\_balancer\_controller\_policy) | Determines whether to attach the Load Balancer Controller policy to the role | `bool` | `false` | no |
| <a name="input_attach_node_termination_handler_policy"></a> [attach\_node\_termination\_handler\_policy](#input\_attach\_node\_termination\_handler\_policy) | Determines whether to attach the Node Termination Handler policy to the role | `bool` | `false` | no |
| <a name="input_attach_vpc_cni_policy"></a> [attach\_vpc\_cni\_policy](#input\_attach\_vpc\_cni\_policy) | Determines whether to attach the VPC CNI IAM policy to the role | `bool` | `false` | no |
| <a name="input_cluster_autoscaler_cluster_ids"></a> [cluster\_autoscaler\_cluster\_ids](#input\_cluster\_autoscaler\_cluster\_ids) | List of cluster IDs to appropriately scope permissions within the Cluster Autoscaler IAM policy | `list(string)` | `[]` | no |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | Whether to create a role | `bool` | `true` | no |
| <a name="input_ebs_csi_kms_cmk_ids"></a> [ebs\_csi\_kms\_cmk\_ids](#input\_ebs\_csi\_kms\_cmk\_ids) | KMS CMK IDs to allow EBS CSI to manage encrypted volumes | `list(string)` | `[]` | no |
| <a name="input_external_dns_hosted_zone_arns"></a> [external\_dns\_hosted\_zone\_arns](#input\_external\_dns\_hosted\_zone\_arns) | Route53 hosted zone ARNs to allow external DNS to manage records | `list(string)` | <pre>[<br>  "arn:aws:route53:::hostedzone/*"<br>]</pre> | no |
| <a name="input_force_detach_policies"></a> [force\_detach\_policies](#input\_force\_detach\_policies) | Whether policies should be detached from this role when destroying | `bool` | `true` | no |
| <a name="input_karpenter_controller_cluster_ids"></a> [karpenter\_controller\_cluster\_ids](#input\_karpenter\_controller\_cluster\_ids) | List of cluster IDs to appropriately scope EC2 permissions within the Karpenter Controller policy | `list(string)` | `[]` | no |
| <a name="input_karpenter_controller_node_iam_role_arns"></a> [karpenter\_controller\_node\_iam\_role\_arns](#input\_karpenter\_controller\_node\_iam\_role\_arns) | List of node IAM role ARNs Karpenter can use to launch nodes | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_karpenter_controller_ssm_parameter_arns"></a> [karpenter\_controller\_ssm\_parameter\_arns](#input\_karpenter\_controller\_ssm\_parameter\_arns) | List of SSM Parameter ARNs that contain AMI IDs launched by Karpenter | `list(string)` | <pre>[<br>  "arn:aws:ssm:*:*:parameter/aws/service/*"<br>]</pre> | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `null` | no |
| <a name="input_node_termination_handler_sqs_queue_arns"></a> [node\_termination\_handler\_sqs\_queue\_arns](#input\_node\_termination\_handler\_sqs\_queue\_arns) | List of SQS ARNs that contain node termination events | `list(string)` | <pre>[<br>  "*"<br>]</pre> | no |
| <a name="input_oidc_providers"></a> [oidc\_providers](#input\_oidc\_providers) | Map of OIDC providers where each provdier map should contain the `provider`, `provider_arns`, and `namespace_service_accounts` | `any` | `{}` | no |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | IAM Role description | `string` | `null` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of IAM role | `string` | `null` | no |
| <a name="input_role_name_prefix"></a> [role\_name\_prefix](#input\_role\_name\_prefix) | IAM role name prefix | `string` | `null` | no |
| <a name="input_role_path"></a> [role\_path](#input\_role\_path) | Path of IAM role | `string` | `null` | no |
| <a name="input_role_permissions_boundary_arn"></a> [role\_permissions\_boundary\_arn](#input\_role\_permissions\_boundary\_arn) | Permissions boundary ARN to use for IAM role | `string` | `null` | no |
| <a name="input_role_policy_arns"></a> [role\_policy\_arns](#input\_role\_policy\_arns) | ARNs of any policies to attach to the IAM role | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add the the IAM role | `map(any)` | `{}` | no |
| <a name="input_vpc_cni_enable_ipv4"></a> [vpc\_cni\_enable\_ipv4](#input\_vpc\_cni\_enable\_ipv4) | Determines whether to enable IPv4 permissions for VPC CNI policy | `bool` | `false` | no |
| <a name="input_vpc_cni_enable_ipv6"></a> [vpc\_cni\_enable\_ipv6](#input\_vpc\_cni\_enable\_ipv6) | Determines whether to enable IPv6 permissions for VPC CNI policy | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of IAM role |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | Name of IAM role |
| <a name="output_iam_role_path"></a> [iam\_role\_path](#output\_iam\_role\_path) | Path of IAM role |
| <a name="output_iam_role_unique_id"></a> [iam\_role\_unique\_id](#output\_iam\_role\_unique\_id) | Unique ID of IAM role |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
