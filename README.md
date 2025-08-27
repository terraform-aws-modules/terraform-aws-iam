# AWS IAM Terraform module

Terraform module which creates AWS IAM resources.

[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

## Usage

Please refer to the AWS published [IAM Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html) for up to date guidance on IAM best practices.

### IAM Account

Creates an account policy and account alias. Module instantiation is once per account.

```hcl
module "iam_account" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-account"

  account_alias = "awesome-company"

  max_password_age               = 90
  minimum_password_length        = 24
  require_uppercase_characters   = true
  require_lowercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  password_reuse_prevention      = 3
  allow_users_to_change_password = true
}
```

### IAM Group

Creates an IAM group with IAM policy attached that one or more users can be added to.

```hcl
module "iam_group" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group"

  name = "superadmins"

  users = [
    "user1",
    "user2"
  ]

  enable_self_management_permissions = true
  permissions = {
    AssumeRole = {
      actions   = ["sts:AssumeRole"]
      resources = ["arn:aws:iam::111111111111:role/admin"]
    }
  }

  policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess",
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

### IAM OIDC Provider

Creates an OpenID connect provider. Useful for trusting external identity providers such as GitHub, Bitbucket, etc.

> [!TIP]
> An IAM provider is 1 per account per given URL. This module would be provisioned once per AWS account, and then one or more roles can be created with this provider as the trusted identity.

```hcl
module "iam_oidc_provider" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-oidc-provider"

  url = "https://token.actions.githubusercontent.com"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

### IAM Policy

Creates an IAM policy.

```hcl
module "iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"

  name        = "example"
  path        = "/"
  description = "My example policy"

  policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": [
            "ec2:Describe*"
          ],
          "Effect": "Allow",
          "Resource": "*"
        }
      ]
    }
  EOF

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

### IAM ReadOnly Policy

Creates an IAM policy that allows read-only access to the list of AWS services provided.

```hcl
module "iam_read_only_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-read-only-policy"

  name        = "example"
  path        = "/"
  description = "My example read-only policy"

  allowed_services = ["rds", "dynamo", "health"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

### IAM Role

Creates an IAM role with a trust policy and (optional) IAM instance profile. Useful for service roles such as EC2, ECS, etc., or roles assumed across AWS accounts.

```hcl
module "iam_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"

  name = "example"

  trust_policy_permissions = {
    TrustRoleAndServiceToAssume = {
      actions = [
        "sts:AssumeRole",
        "sts:TagSession",
      ]
      principals = [{
        type = "AWS"
        identifiers = [
          "arn:aws:iam::835367859851:user/anton",
        ]
      }]
      condition = [{
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = ["some-secret-id"]
      }]
    }
  }

  policies = {
    AmazonCognitoReadOnly      = "arn:aws:iam::aws:policy/AmazonCognitoReadOnly"
    AlexaForBusinessFullAccess = "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess"
    custom                     = aws_iam_policy.this.arn
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

### IAM Role - GitHub OIDC

Creates an IAM role that trusts an OpenID connect provider. Useful for trusting external identity providers such as GitHub, Bitbucket, etc.

```hcl
module "iam_role_github_oidc" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role"

  enable_github_oidc = true

  # This should be updated to suit your organization, repository, references/branches, etc.
  oidc_wildcard_subjects = ["terraform-aws-modules/terraform-aws-iam:*"]

  policies = {
    S3ReadOnly = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

### IAM Role - SAML 2.0

Creates an IAM role that trusts a SAML provider. Useful for trusting external identity providers such as Okta, OneLogin, etc.

```hcl
module "iam_role_saml" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"

  name = "example"

  enable_saml       = true
  saml_provider_ids = ["arn:aws:iam::235367859851:saml-provider/idp_saml"]

  policies = {
    ReadOnlyAccess = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

### IAM Role for EKS Service Accounts (IRSA)

> [!TIP]
> Upgrade to use EKS Pod Identity instead of IRSA
> A similar module for EKS Pod Identity is available [here](https://github.com/terraform-aws-modules/terraform-aws-eks-pod-identity).

Creates an IAM role that is suitable for EKS IAM role for service accounts (IRSA) with a set of pre-defined policies for common EKS addons.

```hcl
module "vpc_cni_irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts"

  name   = "vpc-cni"

  attach_vpc_cni_policy = true
  vpc_cni_enable_ipv4   = true

  oidc_providers = {
    this = {
      provider_arn               = "arn:aws:iam::012345678901:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/5C54DDF35ER19312844C7333374CC09D"
      namespace_service_accounts = ["kube-system:aws-node"]
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

### IAM User

Creates an IAM user with ability to create a login profile, access key, and SSH key.

```hcl
module "iam_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"

  name = "vasya.pupkin"

  force_destroy           = true
  pgp_key                 = "keybase:test"
  password_reset_required = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Examples

- [iam-account](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/examples/iam-account) - Set AWS account alias and password policy
- [iam-group](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/examples/iam-group) - IAM group with users who are allowed to assume IAM roles in another AWS account and have access to specified IAM policies
- [iam-oidc-provider](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/examples/iam-oidc-provider) - Create an OpenID connect provider and IAM role which can be assumed from specified subjects federated from the OIDC provider
- [iam-policy](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/examples/iam-policy) - Create an IAM policy
- [iam-read-only-policy](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/examples/iam-read-only-policy) - Create IAM read-only policy
- [iam-role](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/examples/iam-role) - Create individual IAM role which can be assumed from specified ARNs (AWS accounts, IAM users, etc)
- [iam-role-for-service-accounts](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/examples/iam-role-for-service-accounts) - Create IAM role for service accounts (IRSA) for use within EKS clusters
- [iam-user](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/examples/iam-user) - Add IAM user, login profile and access keys (with PGP enabled or disabled)

## Authors

Module is maintained by [Anton Babenko](https://github.com/antonbabenko) with help from [these awesome contributors](https://github.com/terraform-aws-modules/terraform-aws-iam/graphs/contributors).

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-iam/blob/master/LICENSE).

## Additional information for users from Russia and Belarus

* Russia has [illegally annexed Crimea in 2014](https://en.wikipedia.org/wiki/Annexation_of_Crimea_by_the_Russian_Federation) and [brought the war in Donbas](https://en.wikipedia.org/wiki/War_in_Donbas) followed by [full-scale invasion of Ukraine in 2022](https://en.wikipedia.org/wiki/2022_Russian_invasion_of_Ukraine).
* Russia has brought sorrow and devastations to millions of Ukrainians, killed hundreds of innocent people, damaged thousands of buildings, and forced several million people to flee.
* [Putin khuylo!](https://en.wikipedia.org/wiki/Putin_khuylo!)
