# Individual IAM assumable roles example

Configuration in this directory creates several individual IAM roles which can be assumed from a defined list of [IAM ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-arns).

The main difference between `iam-assumable-role` and `iam-assumable-roles` examples is that the former creates just a single role.

# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No provider.

## Inputs

No input.

## Outputs

| Name | Description |
|------|-------------|
| role\_requires\_mfa | Whether admin IAM role requires MFA |
| this\_iam\_role\_arn | ARN of IAM role |
| this\_iam\_role\_name | Name of IAM role |
| this\_iam\_role\_path | Path of IAM role |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
