# Changelog

All notable changes to this project will be documented in this file.

## [5.32.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.31.0...v5.32.0) (2023-11-17)


### Features

* Add instance profile permissions to Karpenter IRSA policy ([#434](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/434)) ([50348dd](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/50348dd6ac008a38fce1c8d3549915c1dd9ccb65)), closes [#433](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/433)

## [5.31.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.30.2...v5.31.0) (2023-11-13)


### Features

* Allow users to change own password in iam-group-with-policies module ([#435](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/435)) ([eb5b218](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/eb5b21840bdb1e5549c24200920250692844bcee))

### [5.30.2](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.30.1...v5.30.2) (2023-11-10)


### Bug Fixes

* Update AllowManageOwnAccessKeys statement ([#432](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/432)) ([741afc9](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/741afc9017b7600bb41eeefb9a61e61b2f4bd3da))

### [5.30.1](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.30.0...v5.30.1) (2023-11-04)


### Bug Fixes

* Direct policy attachment of `iam-policy`-created resources ([#428](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/428)) ([543f101](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/543f101e286a628d5f324ca794c73b60962ff4ae))

## [5.30.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.29.2...v5.30.0) (2023-08-31)


### Features

* Add `create_custom_role_trust_policy` to control when a `custom_role_trust_policy` should be used ([#321](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/321)) ([481095e](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/481095ee1282860c913158a0775731cb586e600d))

### [5.29.2](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.29.1...v5.29.2) (2023-08-30)


### Bug Fixes

* Expand Permissions for external-secrets IRSA Policy towards AWS Secrets Manager ([#416](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/416)) ([fa74a18](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/fa74a1817cf5aa49cb1ff30f2b1946be706fc640))

### [5.29.1](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.29.0...v5.29.1) (2023-08-30)


### Bug Fixes

* Add missing condition role_session_name when assuming a role ([#418](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/418)) ([89d011e](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/89d011ee19fc9262f26565f6e935ab64e0e15066))

## [5.29.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.28.0...v5.29.0) (2023-08-23)


### Features

* Add variable for adding statement for `secretsmanager:CreateSecret` ([#414](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/414)) ([24996cd](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/24996cd443573c216cc97c9984acb6183f0a6321))

## [5.28.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.27.0...v5.28.0) (2023-07-19)


### Features

* Added direct policy attachment in iam-user module ([#387](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/387)) ([9fa481f](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/9fa481f0c82496fb8f5722147a1d319528d772a5))

## [5.27.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.26.0...v5.27.0) (2023-07-04)


### Features

* Correct enable_mfa_enforcement spelling ([#404](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/404)) ([54b7165](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/54b7165ef00a9701d0ebcdcf37ba6b210feda51a))

## [5.26.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.25.0...v5.26.0) (2023-07-03)


### Features

* Github OIDC add extra thumbprints as needed ([#403](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/403)) ([56511f3](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/56511f3d790f21f0102d5e15e5f6a3304dc646b1))

## [5.25.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.24.0...v5.25.0) (2023-07-02)


### Features

* Added variable load_balancer_controller_targetgroup_arns in iam-role-for-service-accounts-eks module ([#402](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/402)) ([61a5dbe](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/61a5dbe4cca3d844903f784ae0fb176b3ff8e486))

## [5.24.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.23.1...v5.24.0) (2023-06-29)


### Features

* Add `path` variable to IAM group module ([#390](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/390)) ([e5c42c3](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/e5c42c37417f4eb289154d0745c731f55b9f5108))

### [5.23.1](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.23.0...v5.23.1) (2023-06-29)


### Bug Fixes

* Ensure `role_name_condition` is set correctly ([#389](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/389)) ([0024928](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/0024928698ffc9f35213c1fe3564f6eb62664a3f))

## [5.23.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.22.0...v5.23.0) (2023-06-29)


### Features

* Added variable trusted_role_actions to sub modules as a "Action of STS" ([#393](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/393)) ([5702679](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/5702679064861e364aefa909794da440f91f32fc))

## [5.22.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.21.0...v5.22.0) (2023-06-26)


### Features

* Add wrapper modules ([#396](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/396)) ([9284b3e](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/9284b3e0899a1e89b8c3b5a78ddd76da762620ac))

## [5.21.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.20.0...v5.21.0) (2023-06-23)


### Features

* Added permissions to list zone tags in iam-role-for-service-accounts-eks module ([#394](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/394)) ([740945f](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/740945f62ea4c7a90631eaa3131415af5e3fa02b))

## [5.20.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.19.0...v5.20.0) (2023-05-22)


### Features

* Add support for AWS Gateway controller (VPC Lattice) to IRSA module ([#378](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/378)) ([fdee003](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/fdee003477c5f86c4236be08ef6a69dffbcc39fd))

## [5.19.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.18.0...v5.19.0) (2023-05-17)


### Features

* Add support for condition role_session_name when assuming a role ([#379](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/379)) ([5aabe67](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/5aabe67c945a9a1cb05bb5d3820e6e54e4ef8f81))

## [5.18.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.17.1...v5.18.0) (2023-05-07)


### Features

* **iam-eks-role:** Add variable to allow change of IAM assume role condition test operator ([#367](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/367)) ([542fc5a](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/542fc5ab905de0ac904523e48493f1f3174d3806))

### [5.17.1](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.17.0...v5.17.1) (2023-05-05)


### Bug Fixes

* Remove `"autoscaling:UpdateAutoScalingGroup"` permission from cluster-autoscaler IRSA ([#357](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/357)) ([aeb5d7f](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/aeb5d7f3226714014f3cb8957d50de45fcfab007))

## [5.17.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.16.0...v5.17.0) (2023-04-08)


### Features

* Add `name_prefix` to iam-policy and iam-read-only-policy modules ([#369](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/369)) ([5bf5f6f](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/5bf5f6f7e539db6c9bd373370613a78dcf2d79ac))

## [5.16.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.15.0...v5.16.0) (2023-03-27)


### Features

* Add `elasticloadbalancing:AddTags` permissions to AWS Load Balancer Controller policy required for version 2.4.7+ ([#358](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/358)) ([e1403c1](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/e1403c15285137147db2698465e794d17059c848))

## [5.15.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.14.4...v5.15.0) (2023-03-27)


### Features

* Add permissions for instance requirements support for cluster autoscaler IRSA policy ([#356](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/356)) ([fac0cdc](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/fac0cdcc714e9497c3ef161bfa3c6ee94da339ef))

### [5.14.4](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.14.3...v5.14.4) (2023-03-24)


### Bug Fixes

* Add `kms:decrypt` policy for External Secret ([#349](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/349)) ([2359a03](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/2359a03662a5a713f37ed615c36e25ac5a1ee044))

### [5.14.3](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.14.2...v5.14.3) (2023-03-23)


### Bug Fixes

* Do not attach force MFA statement for iam-groups-with-policies by default ([#333](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/333)) ([b9f3409](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/b9f3409fb696abee186b5b914e87ef7a783492a0))

### [5.14.2](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.14.1...v5.14.2) (2023-03-21)


### Bug Fixes

* Add `ssm:DescribeParameters` permission to `external-secrets` IAM role for service account (IRSA) ([#348](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/348)) ([fe8d73b](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/fe8d73b6ee0b96f4578e1744e023112f141b7bc4))

### [5.14.1](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.14.0...v5.14.1) (2023-03-21)


### Bug Fixes

* Update self manage policy to support users with path ([#335](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/335)) ([9a8d5cb](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/9a8d5cb68da61f8bf19e45051f2faf399026dd44))

## [5.14.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.13.0...v5.14.0) (2023-03-17)


### Features

* Update efs_csi policy to support resource tagging ([#352](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/352)) ([47cb7a2](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/47cb7a234786c0ce3d3eb9f403d975a17823ba76))

## [5.13.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.12.0...v5.13.0) (2023-03-10)


### Features

* Add support for `path` in `iam-group-with-assumable-roles-policy` ([#345](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/345)) ([761368e](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/761368e495ca04beaf5259c29fde5e107db7989f))

## [5.12.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.11.2...v5.12.0) (2023-03-08)


### Features

* Add `eks:DescribeCluster` for Karpenter cluster endpoint auto discovery ([#343](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/343)) ([3f2cdc8](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/3f2cdc888e94f4acc45c756c43a0d9f79354b73e))

### [5.11.2](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.11.1...v5.11.2) (2023-02-15)


### Bug Fixes

* Allow Change Password when no MFA present ([#340](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/340)) ([0c1cfaa](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/0c1cfaaaa2a4aca668c1e30800c6c0392976f6bb))

### [5.11.1](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.11.0...v5.11.1) (2023-01-19)


### Bug Fixes

* Reflect the changes in the ebs_csi driver ([#326](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/326)) ([cadfe47](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/cadfe4755411d36c80f4eacc3c513c32f0b879e8))

## [5.11.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.10.0...v5.11.0) (2023-01-19)


### Features

* Allow multiple MFA devices and users to manage MFA devices ([#313](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/313)) ([57a5d70](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/57a5d70ad1ac61dd677daaf58bf9646e26935b09))

## [5.10.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.9.2...v5.10.0) (2023-01-06)


### Features

* Added Extra STS actions param in assumable role with SAML ([#317](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/317)) ([a2ad4cd](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/a2ad4cde3343abe499a9cf7585804663a6298738))


### Bug Fixes

* Use a version for  to avoid GitHub API rate limiting on CI workflows ([#323](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/323)) ([90349fa](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/90349fa122d9b7f043d6678d66da2bf31ba15f93))

### [5.9.2](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.9.1...v5.9.2) (2022-12-10)


### Bug Fixes

* Update `role_name` default to `null` ([#319](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/319)) ([0baa2c1](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/0baa2c10ddd66e48f0d5f9fba1ae5e4fafcf6547))

### [5.9.1](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.9.0...v5.9.1) (2022-12-07)


### Bug Fixes

* Add `ssm:GetParameters` permission to `external-secrets` policy ([#316](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/316)) ([0e77849](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/0e77849cbaddf5482fd21f03bea8007b38a1f50f))

## [5.9.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.8.0...v5.9.0) (2022-12-01)


### Features

* Support IAM access key status ([#315](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/315)) ([705040a](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/705040aa806420522d3e66b9f188d68c143d1561))

## [5.8.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.7.0...v5.8.0) (2022-11-21)


### Features

* Add additional permissions to Karpenter EKS IRSA role for native node termination handling support ([#304](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/304)) ([d6865d2](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/d6865d29eafe709fb3a5682979ea5288f81bb882))

## [5.7.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.6.0...v5.7.0) (2022-11-21)


### Features

* Ensure that GitHub OIDC subject prefixes are normalied for `repo:` ([#310](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/310)) ([b9873a0](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/b9873a0b4772a0b854b3bc4283d7c172df35ab51))

## [5.6.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.5.7...v5.6.0) (2022-11-19)


### Features

* Add support for creating IAM GitHub OIDC provider and role(s) ([#308](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/308)) ([cc44693](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/cc446936d2d3bfd04daa17ef81ae11fbe8c68bc7))

### [5.5.7](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.5.6...v5.5.7) (2022-11-09)


### Bug Fixes

* Add `secretsmanager:ListSecrets` to `external-secrets` policy ([#305](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/305)) ([d3fb017](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/d3fb017ea3439f945ff78ecf06c39690186dff52))

### [5.5.6](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.5.5...v5.5.6) (2022-11-07)


### Bug Fixes

* Update CI configuration files to use latest version ([#302](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/302)) ([4c1c958](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/4c1c95824e17a1af215f216698e796569cce536c))

### [5.5.5](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.5.4...v5.5.5) (2022-11-01)


### Bug Fixes

* Add missing locals in iam-assumable-role module ([#290](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/290)) ([8af6d28](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/8af6d284ad1c22b54783828888469e2edb43b04a))

### [5.5.4](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.5.3...v5.5.4) (2022-10-26)


### Bug Fixes

* Insufficient permissions for karpenter policy when not using karpenter discovery tags on security group ([#294](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/294)) ([5ad496b](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/5ad496bebb49c4a0f3d07b52074a8adfa1134218))

### [5.5.3](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.5.2...v5.5.3) (2022-10-26)


### Bug Fixes

* Correct tflint errors for latest version of tflint ([#296](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/296)) ([b40ade4](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/b40ade467bff316f25220eccb5f641d4e1c716ba))

### [5.5.2](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.5.1...v5.5.2) (2022-10-13)


### Bug Fixes

* Explicitly assume with condition matching role arn ([#283](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/283)) ([470b6ff](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/470b6ffa8e2888dd2699c1fce6010704dda5e2b3))

### [5.5.1](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.5.0...v5.5.1) (2022-10-12)


### Bug Fixes

* Allow TagUser to SelfManagement policy ([#287](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/287)) ([87624b6](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/87624b69f9494d3507f83a57d14d4e0494f08d9e))

## [5.5.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.4.0...v5.5.0) (2022-09-27)


### Features

* Add support for roles created to explicitly assume their own role if desired ([#281](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/281)) ([3d29d26](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/3d29d26018550825a79d90a87195b3023311816b))

## [5.4.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.3.3...v5.4.0) (2022-09-15)


### Features

* Add support for spot request permissions with Karpenter IRSA role ([#277](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/277)) ([b3b99d9](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/b3b99d95bd31462b6fb94a1d6db9a12ef46e00f4))

### [5.3.3](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.3.2...v5.3.3) (2022-09-06)


### Bug Fixes

* Fixed iam-user module when `encrypted_ses_smtp_password_v4` is `null` ([#275](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/275)) ([936d0f1](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/936d0f108606dd380691c9bb4bdce8c511df5246))

### [5.3.2](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.3.1...v5.3.2) (2022-09-05)


### Bug Fixes

* Correct encrypted ses_smtp_password_v4 output ([#259](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/259)) ([ff9d783](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/ff9d783fffb74e47bfc1b65fff1c5c0e64a8b006))

### [5.3.1](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.3.0...v5.3.1) (2022-08-25)


### Bug Fixes

* Don't force users to reset passwords in modules/iam-user ([#271](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/271)) ([358f7d4](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/358f7d438d033df9f463b518ef229333f1027bf6))

## [5.3.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.2.0...v5.3.0) (2022-08-10)


### Features

* Add additional permission for `karpenter` IAM policy added in v0.14.0 release ([#264](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/264)) ([bce17b2](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/bce17b240f79121660d0a84ac0c161dd3806d3e6))

## [5.2.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.1.0...v5.2.0) (2022-06-27)


### Features

* Add additional Karpenter permissions for spot pricing improvements ([#258](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/258)) ([14cc1df](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/14cc1df7f7d21c82fbeb8e08b2950eab58ece056))

## [5.1.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v5.0.0...v5.1.0) (2022-06-01)


### Features

* Update cluster autoscaler policy for recent permission changes upstream ([#255](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/255)) ([2f1b2bf](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/2f1b2bf80501b472be620c88e6339c4f622d4800))

## [5.0.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.24.1...v5.0.0) (2022-05-18)


### ⚠ BREAKING CHANGES

* Replace use of `toset()` for policy attachment, bump min version of AWS provider to `4.0` and Terraform to `1.0` (#250)

### Features

* Replace use of `toset()` for policy attachment, bump min version of AWS provider to `4.0` and Terraform to `1.0` ([#250](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/250)) ([835135b](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/835135b80a8bbde2375f703e9d2849bac091ba2c))

### [4.24.1](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.24.0...v4.24.1) (2022-05-10)


### Bug Fixes

* Avoid restricting Karpenter `RunInstances` subnets by tag key ([#247](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/247)) ([bbbe0c0](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/bbbe0c01c9360b8a5d5b3ef60786d17a7920f33a))

## [4.24.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.23.0...v4.24.0) (2022-05-03)


### Features

* add policy_name_prefix for IRSA policies ([#243](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/243)) ([d932f65](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/d932f65dd0a347e61f542d9e03f2525d5c662d5f)), closes [#239](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/239)

## [4.23.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.22.1...v4.23.0) (2022-04-25)


### Features

* Improved iam-eks-role module (simplified, removed provider_url_sa_pairs, updated docs) ([#236](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/236)) ([d014730](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/d014730ada0ab95d9f97d98b3cbf5192055083bf))

### [4.22.1](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.22.0...v4.22.1) (2022-04-25)


### Bug Fixes

* Correct invalid policy for app mesh controller ([#238](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/238)) ([7362f20](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/7362f20e56911d46c9982949c33905828f46656f))

## [4.22.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.21.1...v4.22.0) (2022-04-23)


### Features

* Add support for Velero IRSA role ([#237](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/237)) ([1ec52b1](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/1ec52b1cb0817d2402a572c229efb5e993132ffe))

### [4.21.1](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.21.0...v4.21.1) (2022-04-22)


### Bug Fixes

* Correct aws arn partition for service account eks ([#235](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/235)) ([e51b6c3](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/e51b6c32230d8cde5ce098880b20a08cb8ae11a1))

## [4.21.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.20.3...v4.21.0) (2022-04-22)


### Features

* Added appmesh controller support to `iam-role-for-service-accounts-eks` ([#231](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/231)) ([0492955](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/0492955751c18f14acbd1b52444cfec14376f0c5))

### [4.20.3](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.20.2...v4.20.3) (2022-04-20)


### Bug Fixes

* Correct policy attachment to cert_manager in example ([#234](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/234)) ([6a28193](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/6a28193534d414c2488db2633ec3399c8bdbda92))

### [4.20.2](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.20.1...v4.20.2) (2022-04-19)


### Bug Fixes

* **efs:** add necessary permissions ([#233](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/233)) ([46da6e9](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/46da6e99f3a2d22a83dca6da874203e4dd44ece1))

### [4.20.1](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.20.0...v4.20.1) (2022-04-15)


### Bug Fixes

* Fixed example where VPC CNI permissions should apply to the `aws-node` account ([#225](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/225)) ([1fb1cfc](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/1fb1cfce34866292f2e13fc86dca30adf09cf21d))

## [4.20.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.19.0...v4.20.0) (2022-04-13)


### Features

* Add support for AMP, cert-manager, and external-secrets to `iam-role-for-service-accounts-eks` ([#223](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/223)) ([f53d409](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/f53d409e9e5c21fc938272e3e063b48b38b690e6))

## [4.19.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.18.0...v4.19.0) (2022-04-12)


### Features

* Add variable to allow changing tag condition on Karpenter `iam-role-for-service-accounts-eks` policy ([#218](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/218)) ([3d7ea33](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/3d7ea3353ff341e9dcd1d238b4ae283c162d822f))

## [4.18.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.17.2...v4.18.0) (2022-04-02)


### Features

* Add support for EFS CSI driver to `iam-role-for-service-accounts-eks` ([#215](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/215)) ([5afe63f](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/5afe63ff093968dbf898ebbb0f8f875328869a49))

### [4.17.2](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.17.1...v4.17.2) (2022-03-31)


### Bug Fixes

* Fixed output of iam_user_login_profile_password in iam-user submodule ([#214](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/214)) ([932a7d8](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/932a7d8016e44075ad4d91545129bdd668784e05))

### [4.17.1](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.17.0...v4.17.1) (2022-03-29)


### Bug Fixes

* Backwards compatibility in 4.x.x series in iam-user submodule ([#212](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/212)) ([2c57668](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/2c57668891916f80336944aaad4f0653eb80dfed))

## [4.17.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.16.0...v4.17.0) (2022-03-26)


### Features

* Make PGP Key Optional in All Cases ([#205](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/205)) ([4242512](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/424251244da66e6ffb7323112d40ae48bd2e1ad5))

## [4.16.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.15.1...v4.16.0) (2022-03-25)


### Features

* Add load_balancer_controller targetgroup binding only role ([#199](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/199)) ([e00526e](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/e00526e5ae97ad814cf9ab92892267d6a7641a57))

### [4.15.1](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.15.0...v4.15.1) (2022-03-23)


### Bug Fixes

* Permit `RunInstances` permission for Karpenter when request contains `karpenter.sh/discovery` tag key ([#209](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/209)) ([18081d1](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/18081d142a88f6552cb6a37958490cafa3368e28))

## [4.15.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.14.0...v4.15.0) (2022-03-23)


### Features

* Made it clear that we stand with Ukraine ([8e2b836](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/8e2b8364752c9842f39a7a79c7ce008b15999191))


### Bug Fixes

* Policy generation when `ebs_csi_kms_cmk_ids` is set ([#203](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/203)) ([e2b4054](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/e2b405400f9259dbd3d5bd2e1fd6b6d5f9061824))

## [4.14.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.13.2...v4.14.0) (2022-03-09)


### Features

* Add variable to change IAM condition test operator to suite; defaults to `StringEquals` ([#201](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/201)) ([8469c03](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/8469c03a40616bad79da6f4e03a00b2ad5e30fd3))

### [4.13.2](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.13.1...v4.13.2) (2022-03-02)


### Bug Fixes

* Trigger release for adding `ec2:DescribeInstanceTypes` patched in [#192](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/192) ([#196](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/196)) ([0f5979f](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/0f5979f76f8290eb43314b5f880e798a22cf4bf0))

### [4.13.1](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.13.0...v4.13.1) (2022-02-18)


### Bug Fixes

* Correct permission on AWS load balancer controller ([#191](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/191)) ([a912557](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/a912557173f6844b75a2104c75de08e68f25d33d))

## [4.13.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.12.0...v4.13.0) (2022-02-17)


### Features

* Add new addon policy for AWS load balancer controller to IRSA role ([#189](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/189)) ([e2ce5c9](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/e2ce5c943f2a4f4c604b0273915f80c55c6a98f3))

## [4.12.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.11.0...v4.12.0) (2022-02-16)


### Features

* Add conditional policy statement attachments for EKS IAM role module ([#184](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/184)) ([e29b94f](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/e29b94f1aaeae68e062213954c293727a8a83e24))

## [4.11.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.10.1...v4.11.0) (2022-02-02)


### Features

* Include cost explorer to default console services in `iam-read-only-policy` module ([#186](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/186)) ([e701139](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/e701139d00abfbadf0695b8186001b9786163863))

### [4.10.1](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.10.0...v4.10.1) (2022-01-21)


### Bug Fixes

* Fixed incorrect example of iam-eks-role ([#183](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/183)) ([c26c44e](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/c26c44ec120a3f791376d52475bb4757e1f8a0ee))

## [4.10.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.9.0...v4.10.0) (2022-01-19)


### Features

* Allow setting custom trust policy in iam-assumable-role ([#176](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/176)) ([095cb29](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/095cb29b2eabed1b7fe0c231a5294c6f0eaa8d5c))

## [4.9.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.8.0...v4.9.0) (2022-01-14)


### Features

* Add new IAM module iam-eks-role ([#179](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/179)) ([61cf542](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/61cf5428fedd898de7f8287af2031a449d644723))

# [4.8.0](https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.7.0...v4.8.0) (2022-01-03)


### Bug Fixes

* update CI/CD process to enable auto-release workflow ([#175](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/175)) ([9278e6f](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/9278e6f02d64ad8f5e569637bc1323b04c032e92))


### Features

* Added iam-read-only-policy module ([#174](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/174)) ([392756f](https://github.com/terraform-aws-modules/terraform-aws-iam/commit/392756f05974b48807572dccfe1ad0614d579556))

<a name="v4.7.0"></a>
## [v4.7.0] - 2021-10-14

- feat: Added support for trusted_role_actions for MFA in iam-assumable-role ([#171](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/171))


<a name="v4.6.0"></a>
## [v4.6.0] - 2021-09-20

- feat: Added output group_arn to iam-group-with-policies ([#165](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/165))


<a name="v4.5.0"></a>
## [v4.5.0] - 2021-09-16

- feat: Added id of iam assumable role to outputs ([#164](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/164))


<a name="v4.4.0"></a>
## [v4.4.0] - 2021-09-10

- feat: Add ability for controlling whether or not to create a policy ([#163](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/163))
- docs: Update version constraints ([#162](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/162))


<a name="v4.3.0"></a>
## [v4.3.0] - 2021-08-18

- feat: Add support for cross account access in iam-assumable-role-with-oidc ([#158](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/158))


<a name="v4.2.0"></a>
## [v4.2.0] - 2021-06-29

- feat: Support External ID with MFA in iam-assumable-role ([#159](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/159))


<a name="v4.1.0"></a>
## [v4.1.0] - 2021-05-03

- feat: Add support tags to additional IAM modules ([#144](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/144))
- chore: update CI/CD to use stable `terraform-docs` release artifact and discoverable Apache2.0 license ([#151](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/151))


<a name="v4.0.0"></a>
## [v4.0.0] - 2021-04-26

- feat: Shorten outputs (removing this_) ([#150](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/150))


<a name="v3.16.0"></a>
## [v3.16.0] - 2021-04-20

- feat: Add iam role unique_id to outputs ([#149](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/149))


<a name="v3.15.0"></a>
## [v3.15.0] - 2021-04-15

- fix: Set sensitive=true for sensitive outputs and use tolist() ([#148](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/148))


<a name="v3.14.0"></a>
## [v3.14.0] - 2021-04-07

- feat: Add role unique_id output in iam-assumable-role module ([#143](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/143))
- chore: update documentation and pin `terraform_docs` version to avoid future changes ([#142](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/142))


<a name="v3.13.0"></a>
## [v3.13.0] - 2021-03-11

- feat: Allows multiple STS External IDs to be provided to an assumable role ([#138](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/138))


<a name="v3.12.0"></a>
## [v3.12.0] - 2021-03-05

- feat: Add iam-assumable-role-with-saml module ([#127](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/127))


<a name="v3.11.0"></a>
## [v3.11.0] - 2021-03-04

- fix: handle unencrypted secrets ([#139](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/139))
- chore: update ci-cd workflow to allow for pulling min version from each directory ([#137](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/137))


<a name="v3.10.0"></a>
## [v3.10.0] - 2021-03-01

- fix: Update syntax for Terraform 0.15 ([#135](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/135))
- chore: Run pre-commit terraform_docs hook ([#133](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/133))
- chore: add ci-cd workflow for pre-commit checks ([#132](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/132))


<a name="v3.9.0"></a>
## [v3.9.0] - 2021-02-20

- chore: update documentation based on latest `terraform-docs` which includes module and resource sections ([#131](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/131))


<a name="v3.8.0"></a>
## [v3.8.0] - 2021-01-29

- feat: Add arn of created group(s) to outputs ([#128](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/128))


<a name="v3.7.0"></a>
## [v3.7.0] - 2021-01-14

- fix: Multiple provider_urls not working with iam-assumable-role-with-oidc ([#115](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/115))


<a name="v3.6.0"></a>
## [v3.6.0] - 2020-12-04

- feat: Fixed number of policies everywhere ([#121](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/121))


<a name="v3.5.0"></a>
## [v3.5.0] - 2020-12-04

- fix: automatically determine the number of role policy arns ([#119](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/119))


<a name="v3.4.0"></a>
## [v3.4.0] - 2020-11-13

- feat: iam-assumable-roles-with-saml - Allow for multiple provider ids ([#110](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/110))


<a name="v3.3.0"></a>
## [v3.3.0] - 2020-11-02

- ci: Updated pre-commit hooks, added terraform_validate ([#106](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/106))


<a name="v3.2.0"></a>
## [v3.2.0] - 2020-10-30

- docs: Updated examples in README ([#105](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/105))


<a name="v3.1.0"></a>
## [v3.1.0] - 2020-10-30

- Bump new major release v3


<a name="v3.0.0"></a>
## [v3.0.0] - 2020-10-30

- feat: Added number_of_ variables for iam-assumable-role submodules ([#96](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/96))


<a name="v2.25.0"></a>
## [v2.25.0] - 2020-10-30

- fix: remove empty string elements from local.urls in iam-assumable-role-with-oidc submodule ([#99](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/99))


<a name="v2.24.0"></a>
## [v2.24.0] - 2020-10-30

- feat: Add role_name_prefix option for oidc roles ([#101](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/101))


<a name="v2.23.0"></a>
## [v2.23.0] - 2020-10-30

- feat: Updated to support Terraform 0.13 also ([#103](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/103))
- ci: Update pre-commit-terraform ([#100](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/100))


<a name="v2.22.0"></a>
## [v2.22.0] - 2020-10-16

- feat: Add role description variable for assumable role with oidc ([#98](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/98))


<a name="v2.21.0"></a>
## [v2.21.0] - 2020-09-22

- fix: Fixed ses_smtp_password_v4 output name


<a name="v2.20.0"></a>
## [v2.20.0] - 2020-09-08

- fix: simplify count statements ([#93](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/93))


<a name="v2.19.0"></a>
## [v2.19.0] - 2020-09-08

- fix: Allow running on custom AWS partition (incl. govcloud) ([#94](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/94))


<a name="v2.18.0"></a>
## [v2.18.0] - 2020-08-18

- feat: modules/iam-assumable-role-with-oidc: Support multiple provider URLs ([#91](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/91))


<a name="v2.17.0"></a>
## [v2.17.0] - 2020-08-17

- feat: Strip https:// from OIDC provider URL if present ([#50](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/50))


<a name="v2.16.0"></a>
## [v2.16.0] - 2020-08-17

- fix: Allow modules/iam-assumable-role-with-oidc to work in govcloud ([#83](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/83))


<a name="v2.15.0"></a>
## [v2.15.0] - 2020-08-17

- feat: Added support for sts:ExternalId in modules/iam-assumable-role ([#90](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/90))


<a name="v2.14.0"></a>
## [v2.14.0] - 2020-08-13

- fix: Delete DEPRECATED ses_smtp_password in iam-user. ([#88](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/88))


<a name="v2.13.0"></a>
## [v2.13.0] - 2020-08-13

- feat: Support for Terraform v0.13 and AWS provider v3 ([#87](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/87))
- docs: Updated example in README ([#52](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/52))


<a name="v2.12.0"></a>
## [v2.12.0] - 2020-06-10

- Updated formatting
- fix: Fix conditions with multiple subjects in assume role with oidc policy ([#74](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/74))


<a name="v2.11.0"></a>
## [v2.11.0] - 2020-06-10

- feat: Allow to set force_detach_policies on roles ([#68](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/68))


<a name="v2.10.0"></a>
## [v2.10.0] - 2020-05-26

- fix: Allow customisation of trusted_role_actions in iam-assumable-role module ([#76](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/76))


<a name="v2.9.0"></a>
## [v2.9.0] - 2020-04-23

- feat: modules/iam-user - Output SMTP password generated with SigV4 algorithm ([#70](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/70))


<a name="v2.8.0"></a>
## [v2.8.0] - 2020-04-22

- docs: Add note about pgp_key when create_iam_login_profile is set ([#69](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/69))
- fix: Fix module source and name in README ([#65](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/65))
- fix typo ([#62](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/62))


<a name="v2.7.0"></a>
## [v2.7.0] - 2020-02-22

- Updated pre-commit-terraform with README
- Add instance profile to role sub-module ([#46](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/46))


<a name="v2.6.0"></a>
## [v2.6.0] - 2020-01-27

- Rename module from "*-iodc" to "*-oidc" ([#48](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/48))


<a name="v2.5.0"></a>
## [v2.5.0] - 2020-01-27

- New sub-module for IAM assumable role with OIDC ([#37](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/37))


<a name="v2.4.0"></a>
## [v2.4.0] - 2020-01-09

- Updated pre-commit hooks
- iam-assumable-role: add description support ([#45](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/45))
- Removed link to missing complete example (fixed [#34](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/34))


<a name="v2.3.0"></a>
## [v2.3.0] - 2019-08-21

- Added description support for custom group policies using a lookup ([#33](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/33))


<a name="v2.2.0"></a>
## [v2.2.0] - 2019-08-21

- Added trusted_role_services to iam-assumable-roles, autoupdated docs
- Add Trusted Services to iam-assumable-role ([#31](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/31))
- Fix link to iam-assumable-role example in README ([#35](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/35))


<a name="v2.1.0"></a>
## [v2.1.0] - 2019-06-11

- Removed duplicated tags from variables in iam-user ([#30](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/30))


<a name="v2.0.0"></a>
## [v2.0.0] - 2019-06-11

- Upgraded module to support Terraform 0.12 ([#29](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/29))


<a name="v1.0.0"></a>
## [v1.0.0] - 2019-06-11

- Fixed styles after [#26](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/26)
- iam-user,iam-assumable-role,iam-assumable-roles,iam-assumable-roles-with-saml tags support ([#26](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/26))


<a name="v0.5.0"></a>
## [v0.5.0] - 2019-05-15

- Added support for list of policies to attach to roles ([#25](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/25))


<a name="v0.4.0"></a>
## [v0.4.0] - 2019-03-16

- Minor adjustments
- assumable roles for Users with SAML Identity Provider  ([#19](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/19))


<a name="v0.3.0"></a>
## [v0.3.0] - 2019-02-20

- Added iam-group-with-policies and iam-group-complete


<a name="v0.2.0"></a>
## [v0.2.0] - 2019-02-19

- Added iam-group-with-assumable-roles-policy and iam-assumable-role ([#18](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/18))


<a name="v0.1.0"></a>
## [v0.1.0] - 2019-02-19

- Updated examples for iam-policy and formatting
- Added iam policy ([#15](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/15))
- Permission boundary ([#16](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/16))


<a name="v0.0.7"></a>
## [v0.0.7] - 2018-08-19

- Follow-up after [#12](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/12), added possibility to upload IAM SSH public keys
- Ssh key support  ([#12](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/12))
- fix descriptions of variables ([#10](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/10))


<a name="v0.0.6"></a>
## [v0.0.6] - 2018-05-28

- Custom Session Duration ([#9](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/9))


<a name="v0.0.5"></a>
## [v0.0.5] - 2018-05-16

- Added pre-commit hook to autogenerate terraform-docs
- Implement conditional logic for role creation ([#7](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/7))


<a name="v0.0.4"></a>
## [v0.0.4] - 2018-03-01

- Add max_password_age for password policy ([#5](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/5))


<a name="v0.0.3"></a>
## [v0.0.3] - 2018-02-28

- Added iam-user module ([#4](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/4))


<a name="v0.0.2"></a>
## [v0.0.2] - 2018-02-12

- Added iam-assumable-roles ([#2](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/2))
- Added iam-account ([#1](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/1))


<a name="v0.0.1"></a>
## v0.0.1 - 2018-02-05

- Do pre-commit run on all code
- Added iam-account
- Initial commit


[Unreleased]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.7.0...HEAD
[v4.7.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.6.0...v4.7.0
[v4.6.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.5.0...v4.6.0
[v4.5.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.4.0...v4.5.0
[v4.4.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.3.0...v4.4.0
[v4.3.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.2.0...v4.3.0
[v4.2.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.1.0...v4.2.0
[v4.1.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v4.0.0...v4.1.0
[v4.0.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v3.16.0...v4.0.0
[v3.16.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v3.15.0...v3.16.0
[v3.15.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v3.14.0...v3.15.0
[v3.14.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v3.13.0...v3.14.0
[v3.13.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v3.12.0...v3.13.0
[v3.12.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v3.11.0...v3.12.0
[v3.11.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v3.10.0...v3.11.0
[v3.10.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v3.9.0...v3.10.0
[v3.9.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v3.8.0...v3.9.0
[v3.8.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v3.7.0...v3.8.0
[v3.7.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v3.6.0...v3.7.0
[v3.6.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v3.5.0...v3.6.0
[v3.5.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v3.4.0...v3.5.0
[v3.4.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v3.3.0...v3.4.0
[v3.3.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v3.2.0...v3.3.0
[v3.2.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v3.1.0...v3.2.0
[v3.1.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v3.0.0...v3.1.0
[v3.0.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.25.0...v3.0.0
[v2.25.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.24.0...v2.25.0
[v2.24.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.23.0...v2.24.0
[v2.23.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.22.0...v2.23.0
[v2.22.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.21.0...v2.22.0
[v2.21.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.20.0...v2.21.0
[v2.20.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.19.0...v2.20.0
[v2.19.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.18.0...v2.19.0
[v2.18.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.17.0...v2.18.0
[v2.17.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.16.0...v2.17.0
[v2.16.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.15.0...v2.16.0
[v2.15.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.14.0...v2.15.0
[v2.14.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.13.0...v2.14.0
[v2.13.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.12.0...v2.13.0
[v2.12.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.11.0...v2.12.0
[v2.11.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.10.0...v2.11.0
[v2.10.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.9.0...v2.10.0
[v2.9.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.8.0...v2.9.0
[v2.8.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.7.0...v2.8.0
[v2.7.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.6.0...v2.7.0
[v2.6.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.5.0...v2.6.0
[v2.5.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.4.0...v2.5.0
[v2.4.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.3.0...v2.4.0
[v2.3.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.2.0...v2.3.0
[v2.2.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.1.0...v2.2.0
[v2.1.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.0.0...v2.1.0
[v2.0.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v1.0.0...v2.0.0
[v1.0.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v0.5.0...v1.0.0
[v0.5.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v0.4.0...v0.5.0
[v0.4.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v0.3.0...v0.4.0
[v0.3.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v0.2.0...v0.3.0
[v0.2.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v0.1.0...v0.2.0
[v0.1.0]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v0.0.7...v0.1.0
[v0.0.7]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v0.0.6...v0.0.7
[v0.0.6]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v0.0.5...v0.0.6
[v0.0.5]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v0.0.4...v0.0.5
[v0.0.4]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v0.0.3...v0.0.4
[v0.0.3]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v0.0.2...v0.0.3
[v0.0.2]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v0.0.1...v0.0.2
