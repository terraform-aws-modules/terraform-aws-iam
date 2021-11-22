# IAM user example

Configuration in this directory creates IAM user with a random password, a pair of IAM access/secret keys and uploads IAM SSH public key.
User password and secret key is encrypted using public key of keybase.io user named `test`.

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

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.6 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.50 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_user"></a> [iam\_user](#module\_iam\_user) | ../../modules/iam-user | n/a |
| <a name="module_iam_user2"></a> [iam\_user2](#module\_iam\_user2) | ../../modules/iam-user | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_access_key_encrypted_secret"></a> [iam\_access\_key\_encrypted\_secret](#output\_iam\_access\_key\_encrypted\_secret) | The encrypted secret, base64 encoded |
| <a name="output_iam_access_key_id"></a> [iam\_access\_key\_id](#output\_iam\_access\_key\_id) | The access key ID |
| <a name="output_iam_access_key_key_fingerprint"></a> [iam\_access\_key\_key\_fingerprint](#output\_iam\_access\_key\_key\_fingerprint) | The fingerprint of the PGP key used to encrypt the secret |
| <a name="output_iam_access_key_secret"></a> [iam\_access\_key\_secret](#output\_iam\_access\_key\_secret) | The access key secret |
| <a name="output_iam_access_key_ses_smtp_password_v4"></a> [iam\_access\_key\_ses\_smtp\_password\_v4](#output\_iam\_access\_key\_ses\_smtp\_password\_v4) | The secret access key converted into an SES SMTP password |
| <a name="output_iam_access_key_status"></a> [iam\_access\_key\_status](#output\_iam\_access\_key\_status) | Active or Inactive. Keys are initially active, but can be made inactive by other means. |
| <a name="output_iam_user_arn"></a> [iam\_user\_arn](#output\_iam\_user\_arn) | The ARN assigned by AWS for this user |
| <a name="output_iam_user_login_profile_encrypted_password"></a> [iam\_user\_login\_profile\_encrypted\_password](#output\_iam\_user\_login\_profile\_encrypted\_password) | The encrypted password, base64 encoded |
| <a name="output_iam_user_login_profile_key_fingerprint"></a> [iam\_user\_login\_profile\_key\_fingerprint](#output\_iam\_user\_login\_profile\_key\_fingerprint) | The fingerprint of the PGP key used to encrypt the password |
| <a name="output_iam_user_name"></a> [iam\_user\_name](#output\_iam\_user\_name) | The user's name |
| <a name="output_iam_user_unique_id"></a> [iam\_user\_unique\_id](#output\_iam\_user\_unique\_id) | The unique ID assigned by AWS |
| <a name="output_keybase_password_decrypt_command"></a> [keybase\_password\_decrypt\_command](#output\_keybase\_password\_decrypt\_command) | Decrypt user password command |
| <a name="output_keybase_password_pgp_message"></a> [keybase\_password\_pgp\_message](#output\_keybase\_password\_pgp\_message) | Encrypted password |
| <a name="output_keybase_secret_key_decrypt_command"></a> [keybase\_secret\_key\_decrypt\_command](#output\_keybase\_secret\_key\_decrypt\_command) | Decrypt access secret key command |
| <a name="output_keybase_secret_key_pgp_message"></a> [keybase\_secret\_key\_pgp\_message](#output\_keybase\_secret\_key\_pgp\_message) | Encrypted access secret key |
| <a name="output_pgp_key"></a> [pgp\_key](#output\_pgp\_key) | PGP key used to encrypt sensitive data for this user (if empty - secrets are not encrypted) |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
