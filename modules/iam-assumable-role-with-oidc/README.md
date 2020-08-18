# iam-assumable-role-with-oidc

Creates single IAM role which can be assumed by trusted resources using OpenID Connect Federated Users.

[Creating IAM OIDC Identity Providers](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_oidc.html)

This module supports IAM Roles for kubernetes service accounts as described in the [EKS documentation](https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html). 

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
| aws\_account\_id | The AWS account ID where the OIDC provider lives, leave empty to use the account for the AWS provider | `string` | `""` | no |
| create\_role | Whether to create a role | `bool` | `false` | no |
| force\_detach\_policies | Whether policies should be detached from this role when destroying | `bool` | `false` | no |
| max\_session\_duration | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `3600` | no |
| oidc\_fully\_qualified\_subjects | The fully qualified OIDC subjects to be added to the role policy | `set(string)` | `[]` | no |
| oidc\_subjects\_with\_wildcards | The OIDC subject using wildcards to be added to the role policy | `set(string)` | `[]` | no |
| provider\_url | URL of the OIDC Provider. Use provider\_urls to specify several URLs. | `string` | `""` | no |
| provider\_urls | List of URLs of the OIDC Providers | `list(string)` | `[]` | no |
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
