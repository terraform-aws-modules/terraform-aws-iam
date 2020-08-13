# iam-assumable-roles-with-saml

Creates predefined IAM roles (admin, poweruser and readonly) which can be assumed by trusted resources using SAML Federated Users.


[Creating IAM SAML Identity Providers](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_saml.html) 
[Enabling SAML 2.0 Federated Users to Access the AWS Management Console](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-saml.html) 

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
| admin\_role\_name | IAM role with admin access | `string` | `"admin"` | no |
| admin\_role\_path | Path of admin IAM role | `string` | `"/"` | no |
| admin\_role\_permissions\_boundary\_arn | Permissions boundary ARN to use for admin role | `string` | `""` | no |
| admin\_role\_policy\_arns | List of policy ARNs to use for admin role | `list(string)` | <pre>[<br>  "arn:aws:iam::aws:policy/AdministratorAccess"<br>]</pre> | no |
| admin\_role\_tags | A map of tags to add to admin role resource. | `map(string)` | `{}` | no |
| aws\_saml\_endpoint | AWS SAML Endpoint | `string` | `"https://signin.aws.amazon.com/saml"` | no |
| create\_admin\_role | Whether to create admin role | `bool` | `false` | no |
| create\_poweruser\_role | Whether to create poweruser role | `bool` | `false` | no |
| create\_readonly\_role | Whether to create readonly role | `bool` | `false` | no |
| force\_detach\_policies | Whether policies should be detached from this role when destroying | `bool` | `false` | no |
| max\_session\_duration | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `3600` | no |
| poweruser\_role\_name | IAM role with poweruser access | `string` | `"poweruser"` | no |
| poweruser\_role\_path | Path of poweruser IAM role | `string` | `"/"` | no |
| poweruser\_role\_permissions\_boundary\_arn | Permissions boundary ARN to use for poweruser role | `string` | `""` | no |
| poweruser\_role\_policy\_arns | List of policy ARNs to use for poweruser role | `list(string)` | <pre>[<br>  "arn:aws:iam::aws:policy/PowerUserAccess"<br>]</pre> | no |
| poweruser\_role\_tags | A map of tags to add to poweruser role resource. | `map(string)` | `{}` | no |
| provider\_id | ID of the SAML Provider | `string` | n/a | yes |
| provider\_name | Name of the SAML Provider | `string` | n/a | yes |
| readonly\_role\_name | IAM role with readonly access | `string` | `"readonly"` | no |
| readonly\_role\_path | Path of readonly IAM role | `string` | `"/"` | no |
| readonly\_role\_permissions\_boundary\_arn | Permissions boundary ARN to use for readonly role | `string` | `""` | no |
| readonly\_role\_policy\_arns | List of policy ARNs to use for readonly role | `list(string)` | <pre>[<br>  "arn:aws:iam::aws:policy/ReadOnlyAccess"<br>]</pre> | no |
| readonly\_role\_tags | A map of tags to add to readonly role resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| admin\_iam\_role\_arn | ARN of admin IAM role |
| admin\_iam\_role\_name | Name of admin IAM role |
| admin\_iam\_role\_path | Path of admin IAM role |
| poweruser\_iam\_role\_arn | ARN of poweruser IAM role |
| poweruser\_iam\_role\_name | Name of poweruser IAM role |
| poweruser\_iam\_role\_path | Path of poweruser IAM role |
| readonly\_iam\_role\_arn | ARN of readonly IAM role |
| readonly\_iam\_role\_name | Name of readonly IAM role |
| readonly\_iam\_role\_path | Path of readonly IAM role |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
