# iam-assumable-role-with-oidc

Creates single IAM role which can be assumed by trusted resources using OpenID Connect Federated Users.

[Creating IAM OIDC Identity Providers](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html)

This module supports IAM Roles for kubernetes service accounts as described in the [EKS documentation](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html). 

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.23 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| aws\_account\_id | The AWS account ID where the OIDC provider lives, leave empty to use the account fo the AWS provider | `string` | `""` | no |
| create\_role | Whether to create a role | `bool` | `false` | no |
| max\_session\_duration | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `3600` | no |
| oidc\_fully\_qualified\_subjects | The fully qualified OIDC subjects to be added to the role policy | `list(string)` | `[]` | no |
| oidc\_subjects\_with\_wildcards | The OIDC subject using wildcards to be added to the role policy | `list(string)` | `[]` | no |
| provider\_url | URL of the OIDC Provider | `string` | n/a | yes |
| role\_name | IAM role name | `string` | `""` | no |
| role\_path | Path of IAM role | `string` | `"/"` | no |
| role\_permissions\_boundary\_arn | Permissions boundary ARN to use for IAM role | `string` | `""` | no |
| role\_policy\_arns | List of ARNs of IAM policies to attach to IAM role | `list(string)` | `[]` | no |
| tags | A map of tags to add to IAM role resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| this\_iam\_role\_arn | ARN of IAM role |
| this\_iam\_role\_name | Name of IAM role |
| this\_iam\_role\_path | Path of IAM role |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
