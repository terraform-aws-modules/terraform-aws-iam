# AWS IAM Group Example

Configuration in this directory creates IAM group with users who are allowed to assume IAM roles and extended with IAM policies.

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
| <a name="module_iam_group"></a> [iam\_group](#module\_iam\_group) | ../../modules/iam-group | n/a |
| <a name="module_iam_group_disabled"></a> [iam\_group\_disabled](#module\_iam\_group\_disabled) | ../../modules/iam-group | n/a |
| <a name="module_iam_user1"></a> [iam\_user1](#module\_iam\_user1) | ../../modules/iam-user | n/a |
| <a name="module_iam_user2"></a> [iam\_user2](#module\_iam\_user2) | ../../modules/iam-user | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_group_arn"></a> [group\_arn](#output\_group\_arn) | The ARN assigned by AWS for this group |
| <a name="output_group_id"></a> [group\_id](#output\_group\_id) | The group's ID |
| <a name="output_group_name"></a> [group\_name](#output\_group\_name) | The group's name |
| <a name="output_group_policy_arn"></a> [group\_policy\_arn](#output\_group\_policy\_arn) | The ARN assigned by AWS for this policy |
| <a name="output_group_policy_id"></a> [group\_policy\_id](#output\_group\_policy\_id) | The policy's ID |
| <a name="output_group_policy_name"></a> [group\_policy\_name](#output\_group\_policy\_name) | The policy's name |
| <a name="output_group_unique_id"></a> [group\_unique\_id](#output\_group\_unique\_id) | The unique ID assigned by AWS |
| <a name="output_group_users"></a> [group\_users](#output\_group\_users) | List of IAM users in IAM group |
<!-- END_TF_DOCS -->
