# iam-policy

Creates IAM policy.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | The name of the policy | string | `` | no |
| path | The path of the policy in IAM | string | `/` | no |
| description | The description of the policy | string | `IAM Policy` | no |
| policy | The path of the policy in IAM (tpl file) | string | `` | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | The policy's ID |
| arn | The ARN assigned by AWS to this policy |
| description | The description of the policy |
| name | The name of the policy |
| path | The path of the policy in IAM |
| policy | The policy document |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
