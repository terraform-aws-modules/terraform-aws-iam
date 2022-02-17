# IAM Role for Service Accounts in EKS

Configuration in this directory creates IAM roles that can be assumed by multiple EKS `ServiceAccount`s for various tasks.

# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cluster_autoscaler_irsa_role"></a> [cluster\_autoscaler\_irsa\_role](#module\_cluster\_autoscaler\_irsa\_role) | ../../modules/iam-role-for-service-accounts-eks | n/a |
| <a name="module_disabled"></a> [disabled](#module\_disabled) | ../../modules/iam-role-for-service-accounts-eks | n/a |
| <a name="module_ebs_csi_irsa_role"></a> [ebs\_csi\_irsa\_role](#module\_ebs\_csi\_irsa\_role) | ../../modules/iam-role-for-service-accounts-eks | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 18.6 |
| <a name="module_external_dns_irsa_role"></a> [external\_dns\_irsa\_role](#module\_external\_dns\_irsa\_role) | ../../modules/iam-role-for-service-accounts-eks | n/a |
| <a name="module_irsa_role"></a> [irsa\_role](#module\_irsa\_role) | ../../modules/iam-role-for-service-accounts-eks | n/a |
| <a name="module_karpenter_controller_irsa_role"></a> [karpenter\_controller\_irsa\_role](#module\_karpenter\_controller\_irsa\_role) | ../../modules/iam-role-for-service-accounts-eks | n/a |
| <a name="module_load_balancer_controller_irsa_role"></a> [load\_balancer\_controller\_irsa\_role](#module\_load\_balancer\_controller\_irsa\_role) | ../../modules/iam-role-for-service-accounts-eks | n/a |
| <a name="module_node_termination_handler_irsa_role"></a> [node\_termination\_handler\_irsa\_role](#module\_node\_termination\_handler\_irsa\_role) | ../../modules/iam-role-for-service-accounts-eks | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 3.0 |
| <a name="module_vpc_cni_ipv4_irsa_role"></a> [vpc\_cni\_ipv4\_irsa\_role](#module\_vpc\_cni\_ipv4\_irsa\_role) | ../../modules/iam-role-for-service-accounts-eks | n/a |
| <a name="module_vpc_cni_ipv6_irsa_role"></a> [vpc\_cni\_ipv6\_irsa\_role](#module\_vpc\_cni\_ipv6\_irsa\_role) | ../../modules/iam-role-for-service-accounts-eks | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of IAM role |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | Name of IAM role |
| <a name="output_iam_role_path"></a> [iam\_role\_path](#output\_iam\_role\_path) | Path of IAM role |
| <a name="output_iam_role_unique_id"></a> [iam\_role\_unique\_id](#output\_iam\_role\_unique\_id) | Unique ID of IAM role |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
