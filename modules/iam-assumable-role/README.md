# iam-assumable-role

Creates single IAM role which can be assumed by trusted resources.

Trusted resources can be any [IAM ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-arns) - typically, AWS accounts and users.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.23 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| admin\_role\_policy\_arn | Policy ARN to use for admin role | `string` | `"arn:aws:iam::aws:policy/AdministratorAccess"` | no |
| attach\_admin\_policy | Whether to attach an admin policy to a role | `bool` | `false` | no |
| attach\_poweruser\_policy | Whether to attach a poweruser policy to a role | `bool` | `false` | no |
| attach\_readonly\_policy | Whether to attach a readonly policy to a role | `bool` | `false` | no |
| create\_instance\_profile | Whether to create an instance profile | `bool` | `false` | no |
| create\_role | Whether to create a role | `bool` | `false` | no |
| custom\_role\_policy\_arns | List of ARNs of IAM policies to attach to IAM role | `list(string)` | `[]` | no |
| max\_session\_duration | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `3600` | no |
| mfa\_age | Max age of valid MFA (in seconds) for roles which require MFA | `number` | `86400` | no |
| poweruser\_role\_policy\_arn | Policy ARN to use for poweruser role | `string` | `"arn:aws:iam::aws:policy/PowerUserAccess"` | no |
| readonly\_role\_policy\_arn | Policy ARN to use for readonly role | `string` | `"arn:aws:iam::aws:policy/ReadOnlyAccess"` | no |
| role\_description | IAM Role description | `string` | `""` | no |
| role\_name | IAM role name | `string` | `""` | no |
| role\_path | Path of IAM role | `string` | `"/"` | no |
| role\_permissions\_boundary\_arn | Permissions boundary ARN to use for IAM role | `string` | `""` | no |
| role\_requires\_mfa | Whether role requires MFA | `bool` | `true` | no |
| tags | A map of tags to add to IAM role resources | `map(string)` | `{}` | no |
| trusted\_role\_arns | ARNs of AWS entities who can assume these roles | `list(string)` | `[]` | no |
| trusted\_role\_services | AWS Services that can assume these roles | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| role\_requires\_mfa | Whether IAM role requires MFA |
| this\_iam\_instance\_profile\_arn | ARN of IAM instance profile |
| this\_iam\_instance\_profile\_name | Name of IAM instance profile |
| this\_iam\_instance\_profile\_path | Path of IAM instance profile |
| this\_iam\_role\_arn | ARN of IAM role |
| this\_iam\_role\_name | Name of IAM role |
| this\_iam\_role\_path | Path of IAM role |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
