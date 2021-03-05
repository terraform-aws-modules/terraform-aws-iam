# iam-assumable-role-with-saml

Creates single IAM role which can be assumed by trusted resources using SAML Federated Users.

[Creating IAM SAML Identity Providers](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_create_saml.html) 
[Enabling SAML 2.0 Federated Users to Access the AWS Management Console](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_providers_enable-console-saml.html) 

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

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) |
| [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_saml\_endpoint | AWS SAML Endpoint | `string` | `"https://signin.aws.amazon.com/saml"` | no |
| create\_role | Whether to create a role | `bool` | `false` | no |
| force\_detach\_policies | Whether policies should be detached from this role when destroying | `bool` | `false` | no |
| max\_session\_duration | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `3600` | no |
| number\_of\_role\_policy\_arns | Number of IAM policies to attach to IAM role | `number` | `null` | no |
| provider\_id | ID of the SAML Provider. Use provider\_ids to specify several IDs. | `string` | `""` | no |
| provider\_ids | List of SAML Provider IDs | `list(string)` | `[]` | no |
| role\_description | IAM Role description | `string` | `""` | no |
| role\_name | IAM role name | `string` | `null` | no |
| role\_name\_prefix | IAM role name prefix | `string` | `null` | no |
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
