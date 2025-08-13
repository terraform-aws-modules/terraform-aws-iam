# AWS IAM ReadOnly Policy Terraform Module

Creates an IAM policy that allows read-only access to the list of AWS services provided.

Default AWS read-only policies (arn:aws:iam::aws:policy/job-function/ViewOnlyAccess, arn:aws:iam::aws:policy/ReadOnlyAccess), being a one-size-fits-all type of policies, have a lot of things missing as well as something that you might not need. Also, AWS default policies are known for having [security issues](https://securityboulevard.com/2020/12/the-aws-managed-policies-trap/). Thus this module is an attempt to build a better base for a customizable usable read-only policy.

## Usage

```hcl
module "iam_read_only_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-read-only-policy"

  name        = "example"
  path        = "/"
  description = "My example read-only policy"

  allowed_services = ["rds", "dynamo", "health"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_cloudwatch_logs_query"></a> [allow\_cloudwatch\_logs\_query](#input\_allow\_cloudwatch\_logs\_query) | Allows StartQuery/StopQuery/FilterLogEvents CloudWatch actions | `bool` | `true` | no |
| <a name="input_allow_predefined_sts_actions"></a> [allow\_predefined\_sts\_actions](#input\_allow\_predefined\_sts\_actions) | Allows GetCallerIdentity/GetSessionToken/GetAccessKeyInfo sts actions | `bool` | `true` | no |
| <a name="input_allow_web_console_services"></a> [allow\_web\_console\_services](#input\_allow\_web\_console\_services) | Allows List/Get/Describe/View actions for services used when browsing AWS console (e.g. resource-groups, tag, health services) | `bool` | `true` | no |
| <a name="input_allowed_services"></a> [allowed\_services](#input\_allowed\_services) | List of services to allow Get/List/Describe/View options. Service name should be the same as corresponding service IAM prefix. See what it is for each service here https://docs.aws.amazon.com/service-authorization/latest/reference/reference_policies_actions-resources-contextkeys.html | `list(string)` | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls if resources should be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_policy"></a> [create\_policy](#input\_create\_policy) | Controls if IAM policy should be created. Set to `false` to generate the policy JSON without creating the policy itself | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the policy | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to use on IAM policy created | `string` | `null` | no |
| <a name="input_override_inline_policy_documents"></a> [override\_inline\_policy\_documents](#input\_override\_inline\_policy\_documents) | List of IAM policy documents that are merged together into the exported document. In merging, statements with non-blank `sid`s will override statements with the same `sid` | `list(string)` | `[]` | no |
| <a name="input_path"></a> [path](#input\_path) | Path of IAM policy | `string` | `null` | no |
| <a name="input_source_inline_policy_documents"></a> [source\_inline\_policy\_documents](#input\_source\_inline\_policy\_documents) | List of IAM policy documents that are merged together into the exported document. Statements must have unique `sid`s | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_use_name_prefix"></a> [use\_name\_prefix](#input\_use\_name\_prefix) | Determines whether the IAM policy name (`name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_web_console_services"></a> [web\_console\_services](#input\_web\_console\_services) | List of web console services to allow | `list(string)` | <pre>[<br/>  "resource-groups",<br/>  "tag",<br/>  "health",<br/>  "ce"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN assigned by AWS to this policy |
| <a name="output_id"></a> [id](#output\_id) | The policy's ID |
| <a name="output_name"></a> [name](#output\_name) | The name of the policy |
| <a name="output_policy"></a> [policy](#output\_policy) | The policy document |
| <a name="output_policy_json"></a> [policy\_json](#output\_policy\_json) | Policy document JSON |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/LICENSE).
