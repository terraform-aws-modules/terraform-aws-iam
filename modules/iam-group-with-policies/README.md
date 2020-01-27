# iam-group-with-policies

Creates IAM group with specified IAM policies, and add users into a group.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.23 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| attach\_iam\_self\_management\_policy | Whether to attach IAM policy which allows IAM users to manage their credentials and MFA | `bool` | `true` | no |
| aws\_account\_id | AWS account id to use inside IAM policies. If empty, current AWS account ID will be used. | `string` | `""` | no |
| create\_group | Whether to create IAM group | `bool` | `true` | no |
| custom\_group\_policies | List of maps of inline IAM policies to attach to IAM group. Should have `name` and `policy` keys in each element. | `list(map(string))` | `[]` | no |
| custom\_group\_policy\_arns | List of IAM policies ARNs to attach to IAM group | `list(string)` | `[]` | no |
| group\_users | List of IAM users to have in an IAM group which can assume the role | `list(string)` | `[]` | no |
| iam\_self\_management\_policy\_name\_prefix | Name prefix for IAM policy to create with IAM self-management permissions | `string` | `"IAMSelfManagement-"` | no |
| name | Name of IAM group | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_account\_id | IAM AWS account id |
| this\_group\_name | IAM group name |
| this\_group\_users | List of IAM users in IAM group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
