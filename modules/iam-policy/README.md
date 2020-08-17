# iam-policy

Creates IAM policy.

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
| description | The description of the policy | `string` | `"IAM Policy"` | no |
| name | The name of the policy | `string` | `""` | no |
| path | The path of the policy in IAM | `string` | `"/"` | no |
| policy | The path of the policy in IAM (tpl file) | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN assigned by AWS to this policy |
| description | The description of the policy |
| id | The policy's ID |
| name | The name of the policy |
| path | The path of the policy in IAM |
| policy | The policy document |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
