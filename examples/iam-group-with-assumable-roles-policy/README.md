# IAM group with assumable roles policy example

Configuration in this directory creates IAM group with users who are allowed to assume IAM roles.

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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.23 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.23 |
| <a name="provider_aws.production"></a> [aws.production](#provider\_aws.production) | >= 2.23 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_assumable_role_custom"></a> [iam\_assumable\_role\_custom](#module\_iam\_assumable\_role\_custom) | ../../modules/iam-assumable-role | n/a |
| <a name="module_iam_assumable_roles_in_prod"></a> [iam\_assumable\_roles\_in\_prod](#module\_iam\_assumable\_roles\_in\_prod) | ../../modules/iam-assumable-roles | n/a |
| <a name="module_iam_group_with_assumable_roles_policy_production_admin"></a> [iam\_group\_with\_assumable\_roles\_policy\_production\_admin](#module\_iam\_group\_with\_assumable\_roles\_policy\_production\_admin) | ../../modules/iam-group-with-assumable-roles-policy | n/a |
| <a name="module_iam_group_with_assumable_roles_policy_production_custom"></a> [iam\_group\_with\_assumable\_roles\_policy\_production\_custom](#module\_iam\_group\_with\_assumable\_roles\_policy\_production\_custom) | ../../modules/iam-group-with-assumable-roles-policy | n/a |
| <a name="module_iam_group_with_assumable_roles_policy_production_readonly"></a> [iam\_group\_with\_assumable\_roles\_policy\_production\_readonly](#module\_iam\_group\_with\_assumable\_roles\_policy\_production\_readonly) | ../../modules/iam-group-with-assumable-roles-policy | n/a |
| <a name="module_iam_user1"></a> [iam\_user1](#module\_iam\_user1) | ../../modules/iam-user | n/a |
| <a name="module_iam_user2"></a> [iam\_user2](#module\_iam\_user2) | ../../modules/iam-user | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.iam](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_caller_identity.production](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_assumable_roles"></a> [assumable\_roles](#output\_assumable\_roles) | List of ARNs of IAM roles which members of IAM group can assume |
| <a name="output_group_users"></a> [group\_users](#output\_group\_users) | List of IAM users in IAM group |
| <a name="output_iam_account_id"></a> [iam\_account\_id](#output\_iam\_account\_id) | IAM AWS account id (this code is managing resources in this account) |
| <a name="output_policy_arn"></a> [policy\_arn](#output\_policy\_arn) | Assume role policy ARN for IAM group |
| <a name="output_production_account_id"></a> [production\_account\_id](#output\_production\_account\_id) | Production AWS account id |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
