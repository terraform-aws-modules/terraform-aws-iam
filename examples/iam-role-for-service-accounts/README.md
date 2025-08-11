# AWS IAM Role for Service Accounts in EKS

> [!TIP]
> Upgrade to use EKS Pod Identity instead of IRSA
> A similar module for EKS Pod Identity is available [here](https://github.com/terraform-aws-modules/terraform-aws-eks-pod-identity).

Configuration in this directory creates IAM roles that can be assumed by multiple EKS `ServiceAccount`s for various tasks.

# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_amazon_managed_service_prometheus_irsa"></a> [amazon\_managed\_service\_prometheus\_irsa](#module\_amazon\_managed\_service\_prometheus\_irsa) | ../../modules/iam-role-for-service-accounts | n/a |
| <a name="module_cert_manager_irsa"></a> [cert\_manager\_irsa](#module\_cert\_manager\_irsa) | ../../modules/iam-role-for-service-accounts | n/a |
| <a name="module_cloudwatch_observability_irsa"></a> [cloudwatch\_observability\_irsa](#module\_cloudwatch\_observability\_irsa) | ../../modules/iam-role-for-service-accounts | n/a |
| <a name="module_cluster_autoscaler_irsa"></a> [cluster\_autoscaler\_irsa](#module\_cluster\_autoscaler\_irsa) | ../../modules/iam-role-for-service-accounts | n/a |
| <a name="module_disabled"></a> [disabled](#module\_disabled) | ../../modules/iam-role-for-service-accounts | n/a |
| <a name="module_ebs_csi_irsa"></a> [ebs\_csi\_irsa](#module\_ebs\_csi\_irsa) | ../../modules/iam-role-for-service-accounts | n/a |
| <a name="module_efs_csi_irsa"></a> [efs\_csi\_irsa](#module\_efs\_csi\_irsa) | ../../modules/iam-role-for-service-accounts | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 21.0 |
| <a name="module_external_dns_irsa"></a> [external\_dns\_irsa](#module\_external\_dns\_irsa) | ../../modules/iam-role-for-service-accounts | n/a |
| <a name="module_external_secrets_irsa"></a> [external\_secrets\_irsa](#module\_external\_secrets\_irsa) | ../../modules/iam-role-for-service-accounts | n/a |
| <a name="module_fsx_lustre_csi_irsa"></a> [fsx\_lustre\_csi\_irsa](#module\_fsx\_lustre\_csi\_irsa) | ../../modules/iam-role-for-service-accounts | n/a |
| <a name="module_fsx_openzfs_csi_irsa"></a> [fsx\_openzfs\_csi\_irsa](#module\_fsx\_openzfs\_csi\_irsa) | ../../modules/iam-role-for-service-accounts | n/a |
| <a name="module_irsa"></a> [irsa](#module\_irsa) | ../../modules/iam-role-for-service-accounts | n/a |
| <a name="module_load_balancer_controller_irsa"></a> [load\_balancer\_controller\_irsa](#module\_load\_balancer\_controller\_irsa) | ../../modules/iam-role-for-service-accounts | n/a |
| <a name="module_load_balancer_controller_targetgroup_binding_only_irsa"></a> [load\_balancer\_controller\_targetgroup\_binding\_only\_irsa](#module\_load\_balancer\_controller\_targetgroup\_binding\_only\_irsa) | ../../modules/iam-role-for-service-accounts | n/a |
| <a name="module_mountpoint_s3_csi_irsa"></a> [mountpoint\_s3\_csi\_irsa](#module\_mountpoint\_s3\_csi\_irsa) | ../../modules/iam-role-for-service-accounts | n/a |
| <a name="module_node_termination_handler_irsa"></a> [node\_termination\_handler\_irsa](#module\_node\_termination\_handler\_irsa) | ../../modules/iam-role-for-service-accounts | n/a |
| <a name="module_velero_irsa"></a> [velero\_irsa](#module\_velero\_irsa) | ../../modules/iam-role-for-service-accounts | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 6.0 |
| <a name="module_vpc_cni_ipv4_irsa"></a> [vpc\_cni\_ipv4\_irsa](#module\_vpc\_cni\_ipv4\_irsa) | ../../modules/iam-role-for-service-accounts | n/a |
| <a name="module_vpc_cni_ipv6_irsa"></a> [vpc\_cni\_ipv6\_irsa](#module\_vpc\_cni\_ipv6\_irsa) | ../../modules/iam-role-for-service-accounts | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.additional](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_irsa_arn"></a> [irsa\_arn](#output\_irsa\_arn) | ARN of IAM role |
| <a name="output_irsa_iam_policy"></a> [irsa\_iam\_policy](#output\_irsa\_iam\_policy) | The policy document |
| <a name="output_irsa_iam_policy_arn"></a> [irsa\_iam\_policy\_arn](#output\_irsa\_iam\_policy\_arn) | The ARN assigned by AWS to this policy |
| <a name="output_irsa_name"></a> [irsa\_name](#output\_irsa\_name) | Name of IAM role |
| <a name="output_irsa_path"></a> [irsa\_path](#output\_irsa\_path) | Path of IAM role |
| <a name="output_irsa_unique_id"></a> [irsa\_unique\_id](#output\_irsa\_unique\_id) | Unique ID of IAM role |
<!-- END_TF_DOCS -->
