# Upgrade from v5.x to v6.x

If you have any questions regarding this upgrade process, please consult the [`examples`](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/examples/) directory:

If you find a bug, please open an issue with supporting configuration to reproduce.

## List of backwards incompatible changes

- `iam-assumable-role` has been renamed to `iam-role`
- `iam-assumable-role-with-oidc` has been renamed to `iam-role-oidc`
- `iam-assumable-role-with-saml` has been renamed to `iam-role-saml`
- `iam-assumable-roles` has been removed; `iam-role` should be used instead. See the [`iam-role` example](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/examples/iam-role) that shows an example replacement implementation.
- `iam-assumable-roles-with-saml` has been removed; `iam-role-saml` should be used instead. See the [`iam-role-saml` example](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/examples/iam-role-saml) that shows an example replacement implementation.
- `iam-github-oidc-provider` has been renamed to `iam-oidc-provider`
- `iam-github-oidc-role` has been removed; `iam-role-oidc` should be used instead. See the [`iam-oidc-provider` example](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/examples/iam-oidc-provider)
- `iam-group-with-assumable-roles-policy` has been removed; the renamed `iam-group` (was `iam-group-with-policies`) should be used instead
- `iam-eks-role` has been removed; `iam-role-for-service-accounts-eks` should be used instead
- `iam-policy` has been removed; the `aws_iam_policy` resource should be used directly instead

## Additional changes

### Modified

- `iam-role`
    - The use of individual variables to control/manipulate the assume role trust policy have been replaced by a generic `assume_role_policy_statements` variable. This allows for any number of custom statements to be added to the role's trust policy.
    - `custom_role_policy_arns` has been renamed to `policies` and now accepts a map of `name`: `policy-arn` pairs; this allows for both existing policies and policies that will get created at the same time as the role. This also replaces the admin, readonly, and poweruser policy ARN variables and their associated `attach_*_policy` variables.
    - Default create conditional is now `true` instead of `false`
    - `force_detach_policies` has been removed; this is now always `true`
- `iam-role-oidc`
    - `custom_role_policy_arns` has been renamed to `policies` and now accepts a map of `name`: `policy-arn` pairs; this allows for both existing policies and policies that will get created at the same time as the role.
    - Default create conditional is now `true` instead of `false`
    - `force_detach_policies` has been removed; this is now always `true`
- `iam-role-saml`
    - `custom_role_policy_arns` has been renamed to `policies` and now accepts a map of `name`: `policy-arn` pairs; this allows for both existing policies and policies that will get created at the same time as the role.
    - Default create conditional is now `true` instead of `false`
    - `force_detach_policies` has been removed; this is now always `true`
- `iam-group`
    - Policy management has been updated to support extending the policy created by the sub-module, as well as adding additional policies that will be attached to the group
    - The role assumption permissions has been removed from the policy; users can extend the policy to add this if needed via `permission_statements`
    - Default create conditional is now `true` instead of `false`

### Variable and output changes

1. Removed variables:

    - `iam-role`
        - `trusted_role_actions`
        - `trusted_role_arns`
        - `trusted_role_services`
        - `mfa_age`
        - `role_requires_mfa`
        - `custom_role_trust_policy`
        - `number_of_custom_role_policy_arns`
        - `admin_role_policy_arn` & `attach_admin_policy`
        - `poweruser_role_policy_arn` & `attach_poweruser_policy`
        - `readonly_role_policy_arn` & `attach_readonly_policy`
        - `force_detach_policies`
        - `role_sts_externalid`
    - `iam-role-oidc`
        - `force_detach_policies`
        - `number_of_custom_role_policy_arns`
    - `iam-role-saml`
        - `force_detach_policies`
        - `number_of_custom_role_policy_arns`
    - `iam-group`
        - `custom_group_policies`
        - `assumable_roles`

2. Renamed variables:

    - `iam-role`
        - `create_role` -> `create`
        - `role_name` -> `name`
        - `role_name_prefix` -> `name_prefix`
        - `role_description` -> `description`
        - `role_path` -> `path`
        - `role_permissions_boundary_arn` -> `permissions_boundary_arn`
        - `custom_role_policy_arns` -> `policies`
    - `iam-role-oidc`
        - `create_role` -> `create`
        - `role_name` -> `name`
        - `role_name_prefix` -> `name_prefix`
        - `role_description` -> `description`
        - `role_path` -> `path`
        - `role_permissions_boundary_arn` -> `permissions_boundary_arn`
        - `custom_role_policy_arns` -> `policies`
    - `iam-role-saml`
        - `create_role` -> `create`
        - `role_name` -> `name`
        - `role_name_prefix` -> `name_prefix`
        - `role_description` -> `description`
        - `role_path` -> `path`
        - `role_permissions_boundary_arn` -> `permissions_boundary_arn`
        - `custom_role_policy_arns` -> `policies`
        - `aws_saml_endpoint` -> `saml_endpoints`
        - `trusted_role_actions` -> `saml_trust_actions`
    - `iam-group`
        - `create_group` -> `create`
        - `group_users` -> `group`
        - `custom_group_policy_arns` -> `policies`
        - `attach_iam_self_management_policy` -> `create_policy`
        - `iam_self_management_policy_name_prefix` -> `policy_name_prefix`
        - `aws_account_id` -> `users_account_id`

3. Added variables:

    - `iam-role`
        - `assume_role_policy_statements` which allows for any number of custom statements to be added to the role's trust policy. This covers the majority of the variables that were removed
    - `iam-role-oidc`
        - `assume_role_policy_statements` which allows for any number of custom statements to be added to the role's trust policy. This covers the majority of the variables that were removed
    - `iam-role-saml`
        - `assume_role_policy_statements` which allows for any number of custom statements to be added to the role's trust policy. This covers the majority of the variables that were removed
    - `iam-group`
        - `permission_statements` which allows for any number of custom statements to be added to the role's trust policy. This covers the majority of the variables that were removed
        - `path`/`policy_path`
        - `create_policy`
        - `enable_mfa_enforcment`

4. Removed outputs:

    - `iam-role`
        - `iam_role_path`
        - `role_requires_mfa`
        - `iam_instance_profile_path`
        - `role_sts_externalid`
    - `iam-role-oidc`
        - `iam_role_path`
        - `provider_url` (use `oidc_provider_urls` instead)
    - `iam-role-saml`
        - `iam_role_path`
        - `provider_id` (use `saml_provider_ids` instead)
    - `iam-group`
        - `assumable_roles`
        - `aws_account_id`

5. Renamed outputs:

    - `iam-role`
        - `iam_role_arn` -> `arn`
        - `iam_role_name` -> `name`
        - `iam_role_unique_id` -> `unique_id`
        - `iam_instance_profile_arn` -> `instance_profile_arn`
        - `iam_instance_profile_id` -> `instance_profile_id`
        - `iam_instance_profile_name` -> `instance_profile_name`
        - `iam_instance_profile_unique_id` -> `instance_profile_unique_id`
    - `iam-role-oidc`
        - `iam_role_arn` -> `arn`
        - `iam_role_name` -> `name`
        - `iam_role_unique_id` -> `unique_id`
        - `aws_account_id` -> `oidc_account_id`
        - `provider_urls` -> `oidc_provider_urls`
    - `iam-role-oidc`
        - `iam_role_arn` -> `arn`
        - `iam_role_name` -> `name`
        - `iam_role_unique_id` -> `unique_id`
        - `aws_account_id` -> `oidc_account_id`
        - `provider_ids` -> `saml_provider_ids`
    - `iam-group`
        - `group_id` -> `id`
        - `group_name` -> `name`
        - `group_arn` -> `arn`
        - `group_users` -> `users`

6. Added outputs:

    - `iam-group`
        - `unique_id`
        - `policy_id`

### Diff of before <> after

#### `iam-role`

```diff
module "iam_role" {
-  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
+  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
-  version = "~> 5.0"
+  version = "~> 6.0"

-  create_role = true
+  create = true # is now `true` by default

-  role_requires_mfa = true
-  trusted_role_arns = [
-    "arn:aws:iam::307990089504:root",
-    "arn:aws:iam::835367859851:user/anton",
-  ]
-  trusted_role_services = [
-    "codedeploy.amazonaws.com"
-  ]
-  role_sts_externalid = ["some-id-goes-here"]
+  assume_role_policy_statements = [
+    {
+      sid = "TrustRoleAndServiceToAssume"
+      principals = [
+        {
+          type = "AWS"
+          identifiers = [
+            "arn:aws:iam::307990089504:root",
+            "arn:aws:iam::835367859851:user/anton",
+          ]
+        },
+        {
+          type = "Service"
+          identifiers = ["codedeploy.amazonaws.com"]
+        }
+      ]
+      conditions = [{
+        test     = "StringEquals"
+        variable = "sts:ExternalId"
+        values   = ["some-secret-id"]
+      }]
+    }
+  ]

-  attach_admin_policy = true
-  custom_role_policy_arns = [
-    "arn:aws:iam::aws:policy/AmazonCognitoReadOnly",
-    "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess",
-    module.iam_policy.arn
-  ]
+  policies = {
+    AdministratorAccess        = "arn:aws:iam::aws:policy/AdministratorAccess"
+    AmazonCognitoReadOnly      = "arn:aws:iam::aws:policy/AmazonCognitoReadOnly"
+    AlexaForBusinessFullAccess = "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess"
+    custom                     = module.iam_policy.arn
+  }
}

### State Changes

None
