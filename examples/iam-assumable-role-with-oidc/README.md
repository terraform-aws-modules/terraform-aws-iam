# Individual IAM assumable role example

Configuration in this directory creates a single IAM role which can be assumed by trusted resources using OpenID Connect Federated Users.

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
| role\_requires\_mfa | Whether admin IAM role requires MFA |
| this\_iam\_role\_arn | ARN of IAM role |
| this\_iam\_role\_name | Name of IAM role |
| this\_iam\_role\_path | Path of IAM role |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
