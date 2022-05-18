# iam-read-only-policy

Creates IAM read-only policy for specified services. Default AWS read-only policies (arn:aws:iam::aws:policy/job-function/ViewOnlyAccess, arn:aws:iam::aws:policy/ReadOnlyAccess), being a one-size-fits-all type of policies, have a lot of things missing as well as something that you might not need. Also, AWS default policies are known for having [security issues](https://securityboulevard.com/2020/12/the-aws-managed-policies-trap/)
Thus this module is an attempt to build a better base for a customizable usable read-only policy.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_document.allowed_services](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.combined](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.console_services](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.logs_query](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.sts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_policy_json"></a> [additional\_policy\_json](#input\_additional\_policy\_json) | JSON policy document if you want to add custom actions | `string` | `"{}"` | no |
| <a name="input_allow_cloudwatch_logs_query"></a> [allow\_cloudwatch\_logs\_query](#input\_allow\_cloudwatch\_logs\_query) | Allows StartQuery/StopQuery/FilterLogEvents CloudWatch actions | `bool` | `true` | no |
| <a name="input_allow_predefined_sts_actions"></a> [allow\_predefined\_sts\_actions](#input\_allow\_predefined\_sts\_actions) | Allows GetCallerIdentity/GetSessionToken/GetAccessKeyInfo sts actions | `bool` | `true` | no |
| <a name="input_allow_web_console_services"></a> [allow\_web\_console\_services](#input\_allow\_web\_console\_services) | Allows List/Get/Describe/View actions for services used when browsing AWS console (e.g. resource-groups, tag, health services) | `bool` | `true` | no |
| <a name="input_allowed_services"></a> [allowed\_services](#input\_allowed\_services) | List of services to allow Get/List/Describe/View options. Service name should be the same as corresponding service IAM prefix. See what it is for each service here https://docs.aws.amazon.com/service-authorization/latest/reference/reference_policies_actions-resources-contextkeys.html | `list(string)` | n/a | yes |
| <a name="input_create_policy"></a> [create\_policy](#input\_create\_policy) | Whether to create the IAM policy | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the policy | `string` | `"IAM Policy"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the policy | `string` | `""` | no |
| <a name="input_path"></a> [path](#input\_path) | The path of the policy in IAM | `string` | `"/"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_web_console_services"></a> [web\_console\_services](#input\_web\_console\_services) | List of web console services to allow | `list(string)` | <pre>[<br>  "resource-groups",<br>  "tag",<br>  "health",<br>  "ce"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN assigned by AWS to this policy |
| <a name="output_description"></a> [description](#output\_description) | The description of the policy |
| <a name="output_id"></a> [id](#output\_id) | The policy's ID |
| <a name="output_name"></a> [name](#output\_name) | The name of the policy |
| <a name="output_path"></a> [path](#output\_path) | The path of the policy in IAM |
| <a name="output_policy"></a> [policy](#output\_policy) | The policy document |
| <a name="output_policy_json"></a> [policy\_json](#output\_policy\_json) | Policy document as json. Useful if you need document but do not want to create IAM policy itself. For example for SSO Permission Set inline policies |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
