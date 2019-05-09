# iam-assumable-roles-with-saml

Creates single IAM role which can be assumed by trusted resources using SAML Federated Users.


[Creating IAM SAML Identity Providers](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_saml.html) 
[Enabling SAML 2.0 Federated Users to Access the AWS Management Console](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-saml.html) 

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| admin\_role\_name | IAM role with admin access | string | `"admin"` | no |
| admin\_role\_path | Path of admin IAM role | string | `"/"` | no |
| admin\_role\_permissions\_boundary\_arn | Permissions boundary ARN to use for admin role | string | `""` | no |
| admin\_role\_policy\_arn | Policy ARN to use for admin role | string | `"arn:aws:iam::aws:policy/AdministratorAccess"` | no |
| admin\_role\_additional\_policies\_arn | Additional Policies ARN to use for admin role | list | `[]` | no |
| admin\_role\_requires\_mfa | Whether admin role requires MFA | string | `"true"` | no |
| create\_admin\_role | Whether to create admin role | string | `"false"` | no |
| create\_poweruser\_role | Whether to create poweruser role | string | `"false"` | no |
| create\_readonly\_role | Whether to create readonly role | string | `"false"` | no |
| max\_session\_duration | Maximum CLI/API session duration in seconds between 3600 and 43200 | string | `"3600"` | no |
| poweruser\_role\_name | IAM role with poweruser access | string | `"poweruser"` | no |
| poweruser\_role\_path | Path of poweruser IAM role | string | `"/"` | no |
| poweruser\_role\_permissions\_boundary\_arn | Permissions boundary ARN to use for poweruser role | string | `""` | no |
| poweruser\_role\_policy\_arn | Policy ARN to use for poweruser role | string | `"arn:aws:iam::aws:policy/PowerUserAccess"` | no |
| poweruser\_role\_additional\_policies\_arn | Additional Policies ARN to use for poweruser role | list | `[]` | no |
| poweruser\_role\_requires\_mfa | Whether poweruser role requires MFA | string | `"true"` | no |
| readonly\_role\_name | IAM role with readonly access | string | `"readonly"` | no |
| readonly\_role\_path | Path of readonly IAM role | string | `"/"` | no |
| readonly\_role\_permissions\_boundary\_arn | Permissions boundary ARN to use for readonly role | string | `""` | no |
| readonly\_role\_policy\_arn | Policy ARN to use for readonly role | string | `"arn:aws:iam::aws:policy/ReadOnlyAccess"` | no |
| readonly\_role\_additional\_policies\_arn | Additional Policies ARN to use for readonly role | list | `[]` | no |
| readonly\_role\_requires\_mfa | Whether readonly role requires MFA | string | `"true"` | no |
| provider\_name | Name of the SAML Provider | string | `""` | yes |
| provider\_id | ID of the SAML Provider | string | `""` | yes |
| aws_saml_endpoint | AWS SAML Endpoint | list | `["https://signin.aws.amazon.com/saml"]` | no |

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
