# IAM user example

Configuration in this directory creates IAM policy.

# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

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
