# AWS Identity and Access Management (IAM) Terraform module

These types of resources are supported:

* [IAM account alias](https://www.terraform.io/docs/providers/aws/r/iam_account_alias.html)
* [IAM password policy](https://www.terraform.io/docs/providers/aws/r/iam_account_password_policy.html)
* [IAM user](https://www.terraform.io/docs/providers/aws/r/iam_user.html)
* [IAM user login profile](https://www.terraform.io/docs/providers/aws/r/iam_user_login_profile.html)
* [IAM group](https://www.terraform.io/docs/providers/aws/r/iam_group.html)
* [IAM role](https://www.terraform.io/docs/providers/aws/r/iam_role.html)
* [IAM access key](https://www.terraform.io/docs/providers/aws/r/iam_access_key.html)

## Usage

`iam-account`:

```hcl
module "iam_account" {
  source = "terraform-aws-modules/iam/aws//modules/iam-account"

  account_alias = "awesome-company"

  minimum_password_length = 37
  require_numbers         = false
}
```

`iam-assumable-roles`:
```hcl
module "iam_assumable_roles" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-roles"

  trusted_role_arns = [
    "arn:aws:iam::307990089504:root",
    "arn:aws:iam::835367859851:user/anton",
  ]

  create_admin_role = true

  create_poweruser_role = true
  poweruser_role_name   = "developer"

  create_readonly_role       = true
  readonly_role_requires_mfa = false
}
```

`iam-user`:
```hcl
module "iam_user" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"

  name          = "vasya.pupkin"
  force_destroy = true

  pgp_key = "keybase:test"

  password_reset_required = false
}
```

`iam-group-with-assumable-roles-policy`:
```hcl
# todo
```

## IAM Best Practices

AWS published [IAM Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html) and this Terraform module was created to help with some of points listed there:

### Create Individual IAM Users

Use [iam-user module](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-user) module to manage IAM users.

### Use AWS Defined Policies to Assign Permissions Whenever Possible

Use [iam-assumable-roles module](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-assumable-roles) to create IAM roles with managed policies to support common tasks (admin, poweruser or readonly). 

### Use Groups to Assign Permissions to IAM Users

Use [iam-group-with-assumable-roles-policy module](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-group-with-assumable-roles-policy) to manage IAM groups of users who can assume roles.

### Configure a Strong Password Policy for Your Users

Use [iam-account module](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-account) to set password policy for your IAM users.

### Enable MFA for Privileged Users

Terraform can't configure MFA for the user. It is only possible via [AWS Console](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa.html) and [AWS CLI](https://docs.aws.amazon.com/cli/latest/reference/iam/enable-mfa-device.html).

### Delegate by Using Roles Instead of by Sharing Credentials

[iam-assumable-roles](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-assumable-roles) and [iam-group-with-assumable-roles-policy](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-group-with-assumable-roles-policy) modules provide complete set of functionality required for this.

### Use Policy Conditions for Extra Security

[iam-assumable-roles module](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-assumable-roles) can be configured to require valid MFA token when different roles are assumed (for example, admin role requires MFA, but readonly - does not).


## Examples

* [complete](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/complete) - Create all required resources to allow one group of users to assume privileged role, while another group of users can only assume readonly role.
* [iam-account](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/examples/iam-account) - Set AWS account alias and password policy
* [iam-assumable-roles](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/examples/iam-assumable-roles) - Create IAM roles which can be assumed from specified ARNs (AWS accounts, IAM users, etc)
* [iam-user](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/examples/iam-user) - Add IAM user, login profile and access keys


## Authors

Module managed by [Anton Babenko](https://github.com/antonbabenko).

## License

Apache 2 Licensed. See LICENSE for full details.
