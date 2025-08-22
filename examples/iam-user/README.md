# AWS IAM User Example

Configuration in this directory creates an IAM user with a random password, a pair of IAM access/secret keys, uploads IAM SSH public key, and demonstrates inline policy creation.
User password and secret key is encrypted using public key of keybase.io user named `test`.

# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_iam_user"></a> [iam\_user](#module\_iam\_user) | ../../modules/iam-user | n/a |
| <a name="module_iam_user2"></a> [iam\_user2](#module\_iam\_user2) | ../../modules/iam-user | n/a |
| <a name="module_iam_user3"></a> [iam\_user3](#module\_iam\_user3) | ../../modules/iam-user | n/a |
| <a name="module_iam_user_disabled"></a> [iam\_user\_disabled](#module\_iam\_user\_disabled) | ../../modules/iam-user | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_user2_access_key_encrypted_secret"></a> [iam\_user2\_access\_key\_encrypted\_secret](#output\_iam\_user2\_access\_key\_encrypted\_secret) | The encrypted secret, base64 encoded |
| <a name="output_iam_user2_access_key_encrypted_ses_smtp_password_v4"></a> [iam\_user2\_access\_key\_encrypted\_ses\_smtp\_password\_v4](#output\_iam\_user2\_access\_key\_encrypted\_ses\_smtp\_password\_v4) | The encrypted secret access key converted into an SES SMTP password by applying AWS's Sigv4 conversion algorithm |
| <a name="output_iam_user2_access_key_fingerprint"></a> [iam\_user2\_access\_key\_fingerprint](#output\_iam\_user2\_access\_key\_fingerprint) | The fingerprint of the PGP key used to encrypt the secret |
| <a name="output_iam_user2_access_key_id"></a> [iam\_user2\_access\_key\_id](#output\_iam\_user2\_access\_key\_id) | The access key ID |
| <a name="output_iam_user2_access_key_secret"></a> [iam\_user2\_access\_key\_secret](#output\_iam\_user2\_access\_key\_secret) | The access key secret |
| <a name="output_iam_user2_access_key_ses_smtp_password_v4"></a> [iam\_user2\_access\_key\_ses\_smtp\_password\_v4](#output\_iam\_user2\_access\_key\_ses\_smtp\_password\_v4) | The secret access key converted into an SES SMTP password by applying AWS's Sigv4 conversion algorithm |
| <a name="output_iam_user2_access_key_status"></a> [iam\_user2\_access\_key\_status](#output\_iam\_user2\_access\_key\_status) | Active or Inactive. Keys are initially active, but can be made inactive by other means |
| <a name="output_iam_user2_arn"></a> [iam\_user2\_arn](#output\_iam\_user2\_arn) | The ARN assigned by AWS for this user |
| <a name="output_iam_user2_login_profile_encrypted_password"></a> [iam\_user2\_login\_profile\_encrypted\_password](#output\_iam\_user2\_login\_profile\_encrypted\_password) | The encrypted password, base64 encoded |
| <a name="output_iam_user2_login_profile_key_fingerprint"></a> [iam\_user2\_login\_profile\_key\_fingerprint](#output\_iam\_user2\_login\_profile\_key\_fingerprint) | The fingerprint of the PGP key used to encrypt the password |
| <a name="output_iam_user2_login_profile_password"></a> [iam\_user2\_login\_profile\_password](#output\_iam\_user2\_login\_profile\_password) | The user password |
| <a name="output_iam_user2_name"></a> [iam\_user2\_name](#output\_iam\_user2\_name) | The user's name |
| <a name="output_iam_user2_ssh_key_fingerprint"></a> [iam\_user2\_ssh\_key\_fingerprint](#output\_iam\_user2\_ssh\_key\_fingerprint) | The MD5 message digest of the SSH public key |
| <a name="output_iam_user2_ssh_key_public_key_id"></a> [iam\_user2\_ssh\_key\_public\_key\_id](#output\_iam\_user2\_ssh\_key\_public\_key\_id) | The unique identifier for the SSH public key |
| <a name="output_iam_user2_unique_id"></a> [iam\_user2\_unique\_id](#output\_iam\_user2\_unique\_id) | The unique ID assigned by AWS |
| <a name="output_iam_user3_access_key_encrypted_secret"></a> [iam\_user3\_access\_key\_encrypted\_secret](#output\_iam\_user3\_access\_key\_encrypted\_secret) | The encrypted secret, base64 encoded |
| <a name="output_iam_user3_access_key_encrypted_ses_smtp_password_v4"></a> [iam\_user3\_access\_key\_encrypted\_ses\_smtp\_password\_v4](#output\_iam\_user3\_access\_key\_encrypted\_ses\_smtp\_password\_v4) | The encrypted secret access key converted into an SES SMTP password by applying AWS's Sigv4 conversion algorithm |
| <a name="output_iam_user3_access_key_fingerprint"></a> [iam\_user3\_access\_key\_fingerprint](#output\_iam\_user3\_access\_key\_fingerprint) | The fingerprint of the PGP key used to encrypt the secret |
| <a name="output_iam_user3_access_key_id"></a> [iam\_user3\_access\_key\_id](#output\_iam\_user3\_access\_key\_id) | The access key ID |
| <a name="output_iam_user3_access_key_secret"></a> [iam\_user3\_access\_key\_secret](#output\_iam\_user3\_access\_key\_secret) | The access key secret |
| <a name="output_iam_user3_access_key_ses_smtp_password_v4"></a> [iam\_user3\_access\_key\_ses\_smtp\_password\_v4](#output\_iam\_user3\_access\_key\_ses\_smtp\_password\_v4) | The secret access key converted into an SES SMTP password by applying AWS's Sigv4 conversion algorithm |
| <a name="output_iam_user3_access_key_status"></a> [iam\_user3\_access\_key\_status](#output\_iam\_user3\_access\_key\_status) | Active or Inactive. Keys are initially active, but can be made inactive by other means |
| <a name="output_iam_user3_arn"></a> [iam\_user3\_arn](#output\_iam\_user3\_arn) | The ARN assigned by AWS for this user |
| <a name="output_iam_user3_login_profile_encrypted_password"></a> [iam\_user3\_login\_profile\_encrypted\_password](#output\_iam\_user3\_login\_profile\_encrypted\_password) | The encrypted password, base64 encoded |
| <a name="output_iam_user3_login_profile_key_fingerprint"></a> [iam\_user3\_login\_profile\_key\_fingerprint](#output\_iam\_user3\_login\_profile\_key\_fingerprint) | The fingerprint of the PGP key used to encrypt the password |
| <a name="output_iam_user3_login_profile_password"></a> [iam\_user3\_login\_profile\_password](#output\_iam\_user3\_login\_profile\_password) | The user password |
| <a name="output_iam_user3_name"></a> [iam\_user3\_name](#output\_iam\_user3\_name) | The user's name |
| <a name="output_iam_user3_ssh_key_fingerprint"></a> [iam\_user3\_ssh\_key\_fingerprint](#output\_iam\_user3\_ssh\_key\_fingerprint) | The MD5 message digest of the SSH public key |
| <a name="output_iam_user3_ssh_key_public_key_id"></a> [iam\_user3\_ssh\_key\_public\_key\_id](#output\_iam\_user3\_ssh\_key\_public\_key\_id) | The unique identifier for the SSH public key |
| <a name="output_iam_user3_unique_id"></a> [iam\_user3\_unique\_id](#output\_iam\_user3\_unique\_id) | The unique ID assigned by AWS |
| <a name="output_iam_user_access_key_encrypted_secret"></a> [iam\_user\_access\_key\_encrypted\_secret](#output\_iam\_user\_access\_key\_encrypted\_secret) | The encrypted secret, base64 encoded |
| <a name="output_iam_user_access_key_encrypted_ses_smtp_password_v4"></a> [iam\_user\_access\_key\_encrypted\_ses\_smtp\_password\_v4](#output\_iam\_user\_access\_key\_encrypted\_ses\_smtp\_password\_v4) | The encrypted secret access key converted into an SES SMTP password by applying AWS's Sigv4 conversion algorithm |
| <a name="output_iam_user_access_key_fingerprint"></a> [iam\_user\_access\_key\_fingerprint](#output\_iam\_user\_access\_key\_fingerprint) | The fingerprint of the PGP key used to encrypt the secret |
| <a name="output_iam_user_access_key_id"></a> [iam\_user\_access\_key\_id](#output\_iam\_user\_access\_key\_id) | The access key ID |
| <a name="output_iam_user_access_key_secret"></a> [iam\_user\_access\_key\_secret](#output\_iam\_user\_access\_key\_secret) | The access key secret |
| <a name="output_iam_user_access_key_ses_smtp_password_v4"></a> [iam\_user\_access\_key\_ses\_smtp\_password\_v4](#output\_iam\_user\_access\_key\_ses\_smtp\_password\_v4) | The secret access key converted into an SES SMTP password by applying AWS's Sigv4 conversion algorithm |
| <a name="output_iam_user_access_key_status"></a> [iam\_user\_access\_key\_status](#output\_iam\_user\_access\_key\_status) | Active or Inactive. Keys are initially active, but can be made inactive by other means |
| <a name="output_iam_user_arn"></a> [iam\_user\_arn](#output\_iam\_user\_arn) | The ARN assigned by AWS for this user |
| <a name="output_iam_user_login_profile_encrypted_password"></a> [iam\_user\_login\_profile\_encrypted\_password](#output\_iam\_user\_login\_profile\_encrypted\_password) | The encrypted password, base64 encoded |
| <a name="output_iam_user_login_profile_key_fingerprint"></a> [iam\_user\_login\_profile\_key\_fingerprint](#output\_iam\_user\_login\_profile\_key\_fingerprint) | The fingerprint of the PGP key used to encrypt the password |
| <a name="output_iam_user_login_profile_password"></a> [iam\_user\_login\_profile\_password](#output\_iam\_user\_login\_profile\_password) | The user password |
| <a name="output_iam_user_name"></a> [iam\_user\_name](#output\_iam\_user\_name) | The user's name |
| <a name="output_iam_user_ssh_key_fingerprint"></a> [iam\_user\_ssh\_key\_fingerprint](#output\_iam\_user\_ssh\_key\_fingerprint) | The MD5 message digest of the SSH public key |
| <a name="output_iam_user_ssh_key_public_key_id"></a> [iam\_user\_ssh\_key\_public\_key\_id](#output\_iam\_user\_ssh\_key\_public\_key\_id) | The unique identifier for the SSH public key |
| <a name="output_iam_user_unique_id"></a> [iam\_user\_unique\_id](#output\_iam\_user\_unique\_id) | The unique ID assigned by AWS |
<!-- END_TF_DOCS -->
