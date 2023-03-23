# IAM group with policies example

Configuration in this directory creates IAM group with users who has specified IAM policies.

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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_group_superadmins"></a> [iam\_group\_superadmins](#module\_iam\_group\_superadmins) | ../../modules/iam-group-with-policies | n/a |
| <a name="module_iam_group_with_custom_policies"></a> [iam\_group\_with\_custom\_policies](#module\_iam\_group\_with\_custom\_policies) | ../../modules/iam-group-with-policies | n/a |
| <a name="module_iam_user1"></a> [iam\_user1](#module\_iam\_user1) | ../../modules/iam-user | n/a |
| <a name="module_iam_user2"></a> [iam\_user2](#module\_iam\_user2) | ../../modules/iam-user | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy_document.sample](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_group_arn"></a> [group\_arn](#output\_group\_arn) | IAM group arn |
| <a name="output_group_name"></a> [group\_name](#output\_group\_name) | IAM group name |
| <a name="output_group_users"></a> [group\_users](#output\_group\_users) | List of IAM users in IAM group |
| <a name="output_iam_account_id"></a> [iam\_account\_id](#output\_iam\_account\_id) | IAM AWS account id |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
