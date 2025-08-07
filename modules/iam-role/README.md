# AWS IAM Role Terraform Module

Creates an IAM role with a trust policy and (optional) IAM instance profile. Useful for service roles such as EC2, ECS, etc., or roles assumed across AWS accounts.

## Usage

```hcl
module "iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"

  name = "example"

  assume_role_policy_statements = [
    {
      sid = "TrustRoleAndServiceToAssume"
      principals = [{
        type = "AWS"
        identifiers = [
          "arn:aws:iam::835367859851:user/anton",
        ]
      }]
      conditions = [{
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = ["some-secret-id"]
      }]
    }
  ]

  policies = {
    AmazonCognitoReadOnly      = "arn:aws:iam::aws:policy/AmazonCognitoReadOnly"
    AlexaForBusinessFullAccess = "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess"
    custom                     = aws_iam_policy.this.arn
  }

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
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_policy_statements"></a> [assume\_role\_policy\_statements](#input\_assume\_role\_policy\_statements) | List of IAM policy [statements](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document#statement) for for trusted assume role policy | <pre>list(object({<br/>    sid           = optional(string)<br/>    actions       = optional(list(string))<br/>    not_actions   = optional(list(string))<br/>    effect        = optional(string)<br/>    resources     = optional(list(string))<br/>    not_resources = optional(list(string))<br/>    principals = optional(list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    })))<br/>    not_principals = optional(list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    })))<br/>    condition = optional(list(object({<br/>      test     = string<br/>      values   = list(string)<br/>      variable = string<br/>    })))<br/>  }))</pre> | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Controls if resources should be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_instance_profile"></a> [create\_instance\_profile](#input\_create\_instance\_profile) | Determines whether to create an instance profile | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the role | `string` | `null` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to use on IAM role created | `string` | `null` | no |
| <a name="input_path"></a> [path](#input\_path) | Path of IAM role | `string` | `"/"` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | ARN of the policy that is used to set the permissions boundary for the IAM role | `string` | `null` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | Policies to attach to the IAM role in `{'static_name' = 'policy_arn'}` format | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_use_name_prefix"></a> [use\_name\_prefix](#input\_use\_name\_prefix) | Determines whether the IAM role name (`name`) is used as a prefix | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) specifying the IAM role |
| <a name="output_instance_profile_arn"></a> [instance\_profile\_arn](#output\_instance\_profile\_arn) | ARN assigned by AWS to the instance profile |
| <a name="output_instance_profile_id"></a> [instance\_profile\_id](#output\_instance\_profile\_id) | Instance profile's ID |
| <a name="output_instance_profile_name"></a> [instance\_profile\_name](#output\_instance\_profile\_name) | Name of IAM instance profile |
| <a name="output_instance_profile_unique_id"></a> [instance\_profile\_unique\_id](#output\_instance\_profile\_unique\_id) | Stable and unique string identifying the IAM instance profile |
| <a name="output_name"></a> [name](#output\_name) | The name of the IAM role |
| <a name="output_unique_id"></a> [unique\_id](#output\_unique\_id) | Stable and unique string identifying the IAM role |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/LICENSE).
