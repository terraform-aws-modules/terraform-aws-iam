# Complete IAM group example

Configuration in this directory creates IAM group with users who are allowed to assume IAM roles and extended with IAM policies.

This is a combination of `iam-group-with-assumable-roles-policy` and `iam-group-with-policies` exampled.

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

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_group_complete"></a> [iam\_group\_complete](#module\_iam\_group\_complete) | ../../modules/iam-group-with-assumable-roles-policy | n/a |
| <a name="module_iam_group_complete_with_custom_policy"></a> [iam\_group\_complete\_with\_custom\_policy](#module\_iam\_group\_complete\_with\_custom\_policy) | ../../modules/iam-group-with-policies | n/a |
| <a name="module_iam_user1"></a> [iam\_user1](#module\_iam\_user1) | ../../modules/iam-user | n/a |
| <a name="module_iam_user2"></a> [iam\_user2](#module\_iam\_user2) | ../../modules/iam-user | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_assumable_roles"></a> [assumable\_roles](#output\_assumable\_roles) | List of ARNs of IAM roles which members of IAM group can assume |
| <a name="output_group_users"></a> [group\_users](#output\_group\_users) | List of IAM users in IAM group |
| <a name="output_policy_arn"></a> [policy\_arn](#output\_policy\_arn) | Assume role policy ARN for IAM group |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
