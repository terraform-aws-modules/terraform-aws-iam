<a name="unreleased"></a>
## [Unreleased]



<a name="v2.6.0"></a>
## [v2.6.0] - 2020-01-27

- Rename module from "*-iodc" to "*-oidc" ([#48](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/48))


<a name="v2.5.0"></a>
## [v2.5.0] - 2020-01-27

- Updated CHANGELOG
- New sub-module for IAM assumable role with OIDC ([#37](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/37))


<a name="v2.4.0"></a>
## [v2.4.0] - 2020-01-09

- Updated CHANGELOG
- Updated pre-commit hooks
- iam-assumable-role: add description support ([#45](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/45))
- Removed link to missing complete example (fixed [#34](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/34))


<a name="v2.3.0"></a>
## [v2.3.0] - 2019-08-21

- Updated CHANGELOG
- Added description support for custom group policies using a lookup ([#33](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/33))


<a name="v2.2.0"></a>
## [v2.2.0] - 2019-08-21

- Updated CHANGELOG
- Added trusted_role_services to iam-assumable-roles, autoupdated docs
- Add Trusted Services to iam-assumable-role ([#31](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/31))
- Fix link to iam-assumable-role example in README ([#35](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/35))


<a name="v2.1.0"></a>
## [v2.1.0] - 2019-06-11

- Updated CHANGELOG
- Removed duplicated tags from variables in iam-user ([#30](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/30))


<a name="v2.0.0"></a>
## [v2.0.0] - 2019-06-11

- Updated CHANGELOG
- Upgraded module to support Terraform 0.12 ([#29](https://github.com/terraform-aws-modules/terraform-aws-iam/issues/29))


<a name="v1.0.0"></a>
## [v1.0.0] - 2019-06-11

- Updated CHANGELOG
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


[Unreleased]: https://github.com/terraform-aws-modules/terraform-aws-iam/compare/v2.6.0...HEAD
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
