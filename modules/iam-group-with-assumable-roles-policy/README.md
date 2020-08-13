# iam-group-with-assumable-roles-policy

Creates IAM group with users who are allowed to assume IAM roles. This is typically done in resource AWS account where IAM users can jump into from IAM AWS account.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.6, < 0.14 |
| aws | >= 2.23, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.23, < 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assumable\_roles | List of IAM roles ARNs which can be assumed by the group | `list(string)` | `[]` | no |
| group\_users | List of IAM users to have in an IAM group which can assume the role | `list(string)` | `[]` | no |
| name | Name of IAM policy and IAM group | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| group\_name | IAM group name |
| this\_assumable\_roles | List of ARNs of IAM roles which members of IAM group can assume |
| this\_group\_users | List of IAM users in IAM group |
| this\_policy\_arn | Assume role policy ARN of IAM group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
