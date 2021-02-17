# Change Log

All notable changes to this project will be documented in this file.

<a name="unreleased"></a>
## [Unreleased]



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


[Unreleased]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v3.8.0...HEAD
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
