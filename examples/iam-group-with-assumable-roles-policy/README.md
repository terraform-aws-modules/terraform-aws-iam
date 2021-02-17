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
| terraform | >= 0.12.6 |
| aws | >= 2.23 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.23 |
| aws.production | >= 2.23 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| iam_assumable_role_custom | ../../modules/iam-assumable-role |  |
| iam_assumable_roles_in_prod | ../../modules/iam-assumable-roles |  |
| iam_group_with_assumable_roles_policy_production_admin | ../../modules/iam-group-with-assumable-roles-policy |  |
| iam_group_with_assumable_roles_policy_production_custom | ../../modules/iam-group-with-assumable-roles-policy |  |
| iam_group_with_assumable_roles_policy_production_readonly | ../../modules/iam-group-with-assumable-roles-policy |  |
| iam_user1 | ../../modules/iam-user |  |
| iam_user2 | ../../modules/iam-user |  |

## Resources

| Name |
|------|
| [aws_caller_identity](https://registry.terraform.io/providers/hashicorp/aws/2.23/docs/data-sources/caller_identity) |

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| iam\_account\_id | IAM AWS account id (this code is managing resources in this account) |
| production\_account\_id | Production AWS account id |
| this\_assumable\_roles | List of ARNs of IAM roles which members of IAM group can assume |
| this\_group\_users | List of IAM users in IAM group |
| this\_policy\_arn | Assume role policy ARN for IAM group |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
