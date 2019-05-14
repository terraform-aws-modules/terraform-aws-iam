# iam-assumable-roles

Creates predefined IAM roles (admin, poweruser and readonly) which can be assumed by trusted resources.

Trusted resources can be any [IAM ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-arns) - typically, AWS accounts and users.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| admin\_role\_name | IAM role with admin access | string | `"admin"` | no |
| admin\_role\_path | Path of admin IAM role | string | `"/"` | no |
| admin\_role\_permissions\_boundary\_arn | Permissions boundary ARN to use for admin role | string | `""` | no |
| admin\_role\_policy\_arn | Policy ARN to use for admin role | string | `"arn:aws:iam::aws:policy/AdministratorAccess"` | no |
| admin\_role\_additional\_policies\_arns | Additional Policies ARNs to use for admin role | list | `[]` | no |
| admin\_role\_requires\_mfa | Whether admin role requires MFA | string | `"true"` | no |
| create\_admin\_role | Whether to create admin role | string | `"false"` | no |
| create\_poweruser\_role | Whether to create poweruser role | string | `"false"` | no |
| create\_readonly\_role | Whether to create readonly role | string | `"false"` | no |
| max\_session\_duration | Maximum CLI/API session duration in seconds between 3600 and 43200 | string | `"3600"` | no |
| mfa\_age | Max age of valid MFA (in seconds) for roles which require MFA | string | `"86400"` | no |
| poweruser\_role\_name | IAM role with poweruser access | string | `"poweruser"` | no |
| poweruser\_role\_path | Path of poweruser IAM role | string | `"/"` | no |
| poweruser\_role\_permissions\_boundary\_arn | Permissions boundary ARN to use for poweruser role | string | `""` | no |
| poweruser\_role\_policy\_arn | Policy ARN to use for poweruser role | string | `"arn:aws:iam::aws:policy/PowerUserAccess"` | no |
| poweruser\_role\_additional\_policies\_arns | Additional Policies ARNs to use for poweruser role | list | `[]` | no |
| poweruser\_role\_requires\_mfa | Whether poweruser role requires MFA | string | `"true"` | no |
| readonly\_role\_name | IAM role with readonly access | string | `"readonly"` | no |
| readonly\_role\_path | Path of readonly IAM role | string | `"/"` | no |
| readonly\_role\_permissions\_boundary\_arns | Permissions boundary ARN to use for readonly role | string | `""` | no |
| readonly\_role\_policy\_arn | Policy ARN to use for readonly role | string | `"arn:aws:iam::aws:policy/ReadOnlyAccess"` | no |
| readonly\_role\_additional\_policies\_arn | Additional Policies ARNs to use for readonly role | list | `[]` | no |
| readonly\_role\_requires\_mfa | Whether readonly role requires MFA | string | `"true"` | no |
| trusted\_role\_arns | ARNs of AWS entities who can assume these roles | list | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| admin\_iam\_role\_arn | ARN of admin IAM role |
| admin\_iam\_role\_name | Name of admin IAM role |
| admin\_iam\_role\_path | Path of admin IAM role |
| admin\_iam\_role\_requires\_mfa | Whether admin IAM role requires MFA |
| poweruser\_iam\_role\_arn | ARN of poweruser IAM role |
| poweruser\_iam\_role\_name | Name of poweruser IAM role |
| poweruser\_iam\_role\_path | Path of poweruser IAM role |
| poweruser\_iam\_role\_requires\_mfa | Whether poweruser IAM role requires MFA |
| readonly\_iam\_role\_arn | ARN of readonly IAM role |
| readonly\_iam\_role\_name | Name of readonly IAM role |
| readonly\_iam\_role\_path | Path of readonly IAM role |
| readonly\_iam\_role\_requires\_mfa | Whether readonly IAM role requires MFA |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
