# iam-user

Creates IAM user, IAM login profile, IAM access key and uploads IAM SSH user public key. All of these are optional resources.

## Notes for keybase users

**If possible, always use PGP encryption to prevent Terraform from keeping unencrypted password and access secret key in state file.**

### Keybase pre-requisits

When `pgp_key` is specified as `keybase:username`, make sure that that user has already uploaded public key to keybase.io. For example, user with username `test` has done it properly and you can [verify it here](https://keybase.io/test/pgp_keys.asc).

### How to decrypt user's encrypted password and secret key

This module outputs commands and PGP messages which can be decrypted either using [keybase.io web-site](https://keybase.io/decrypt) or using command line to get user's password and user's secret key:
- `keybase_password_decrypt_command`
- `keybase_secret_key_decrypt_command`
- `keybase_password_pgp_message`
- `keybase_secret_key_pgp_message`

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
| [aws_iam_access_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_access_key.this_no_pgp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_login_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_login_profile) | resource |
| [aws_iam_user_ssh_key.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_ssh_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_iam_access_key"></a> [create\_iam\_access\_key](#input\_create\_iam\_access\_key) | Whether to create IAM access key | `bool` | `true` | no |
| <a name="input_create_iam_user_login_profile"></a> [create\_iam\_user\_login\_profile](#input\_create\_iam\_user\_login\_profile) | Whether to create IAM user login profile | `bool` | `true` | no |
| <a name="input_create_user"></a> [create\_user](#input\_create\_user) | Whether to create the IAM user | `bool` | `true` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force\_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Desired name for the IAM user | `string` | n/a | yes |
| <a name="input_password_length"></a> [password\_length](#input\_password\_length) | The length of the generated password | `number` | `20` | no |
| <a name="input_password_reset_required"></a> [password\_reset\_required](#input\_password\_reset\_required) | Whether the user should be forced to reset the generated password on first login. | `bool` | `true` | no |
| <a name="input_path"></a> [path](#input\_path) | Desired path for the IAM user | `string` | `"/"` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | The ARN of the policy that is used to set the permissions boundary for the user. | `string` | `""` | no |
| <a name="input_pgp_key"></a> [pgp\_key](#input\_pgp\_key) | Either a base-64 encoded PGP public key, or a keybase username in the form `keybase:username`. Used to encrypt password and access key. | `string` | `""` | no |
| <a name="input_ssh_key_encoding"></a> [ssh\_key\_encoding](#input\_ssh\_key\_encoding) | Specifies the public key encoding format to use in the response. To retrieve the public key in ssh-rsa format, use SSH. To retrieve the public key in PEM format, use PEM | `string` | `"SSH"` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | The SSH public key. The public key must be encoded in ssh-rsa format or PEM format | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_upload_iam_user_ssh_key"></a> [upload\_iam\_user\_ssh\_key](#input\_upload\_iam\_user\_ssh\_key) | Whether to upload a public ssh key to the IAM user | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_access_key_encrypted_secret"></a> [iam\_access\_key\_encrypted\_secret](#output\_iam\_access\_key\_encrypted\_secret) | The encrypted secret, base64 encoded |
| <a name="output_iam_access_key_id"></a> [iam\_access\_key\_id](#output\_iam\_access\_key\_id) | The access key ID |
| <a name="output_iam_access_key_key_fingerprint"></a> [iam\_access\_key\_key\_fingerprint](#output\_iam\_access\_key\_key\_fingerprint) | The fingerprint of the PGP key used to encrypt the secret |
| <a name="output_iam_access_key_secret"></a> [iam\_access\_key\_secret](#output\_iam\_access\_key\_secret) | The access key secret |
| <a name="output_iam_access_key_ses_smtp_password_v4"></a> [iam\_access\_key\_ses\_smtp\_password\_v4](#output\_iam\_access\_key\_ses\_smtp\_password\_v4) | The secret access key converted into an SES SMTP password by applying AWS's Sigv4 conversion algorithm |
| <a name="output_iam_access_key_status"></a> [iam\_access\_key\_status](#output\_iam\_access\_key\_status) | Active or Inactive. Keys are initially active, but can be made inactive by other means. |
| <a name="output_iam_user_arn"></a> [iam\_user\_arn](#output\_iam\_user\_arn) | The ARN assigned by AWS for this user |
| <a name="output_iam_user_login_profile_encrypted_password"></a> [iam\_user\_login\_profile\_encrypted\_password](#output\_iam\_user\_login\_profile\_encrypted\_password) | The encrypted password, base64 encoded |
| <a name="output_iam_user_login_profile_key_fingerprint"></a> [iam\_user\_login\_profile\_key\_fingerprint](#output\_iam\_user\_login\_profile\_key\_fingerprint) | The fingerprint of the PGP key used to encrypt the password |
| <a name="output_iam_user_login_profile_password"></a> [iam\_user\_login\_profile\_password](#output\_iam\_user\_login\_profile\_password) | The user password |
| <a name="output_iam_user_name"></a> [iam\_user\_name](#output\_iam\_user\_name) | The user's name |
| <a name="output_iam_user_ssh_key_fingerprint"></a> [iam\_user\_ssh\_key\_fingerprint](#output\_iam\_user\_ssh\_key\_fingerprint) | The MD5 message digest of the SSH public key |
| <a name="output_iam_user_ssh_key_ssh_public_key_id"></a> [iam\_user\_ssh\_key\_ssh\_public\_key\_id](#output\_iam\_user\_ssh\_key\_ssh\_public\_key\_id) | The unique identifier for the SSH public key |
| <a name="output_iam_user_unique_id"></a> [iam\_user\_unique\_id](#output\_iam\_user\_unique\_id) | The unique ID assigned by AWS |
| <a name="output_keybase_password_decrypt_command"></a> [keybase\_password\_decrypt\_command](#output\_keybase\_password\_decrypt\_command) | Decrypt user password command |
| <a name="output_keybase_password_pgp_message"></a> [keybase\_password\_pgp\_message](#output\_keybase\_password\_pgp\_message) | Encrypted password |
| <a name="output_keybase_secret_key_decrypt_command"></a> [keybase\_secret\_key\_decrypt\_command](#output\_keybase\_secret\_key\_decrypt\_command) | Decrypt access secret key command |
| <a name="output_keybase_secret_key_pgp_message"></a> [keybase\_secret\_key\_pgp\_message](#output\_keybase\_secret\_key\_pgp\_message) | Encrypted access secret key |
| <a name="output_pgp_key"></a> [pgp\_key](#output\_pgp\_key) | PGP key used to encrypt sensitive data for this user (if empty - secrets are not encrypted) |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
