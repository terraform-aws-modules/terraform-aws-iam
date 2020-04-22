# Complete IAM group example

Configuration in this directory creates IAM group with users who are allowed to assume IAM roles and extended with IAM policies.

This is a combination of `iam-group-with-assumable-roles-policy` and `iam-group-with-policies` exampled.

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
| this\_assumable\_roles | List of ARNs of IAM roles which members of IAM group can assume |
| this\_group\_users | List of IAM users in IAM group |
| this\_policy\_arn | Assume role policy ARN for IAM group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
