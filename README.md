<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Usage

Configures IAM policy to allow users to manage their own credentials and optionally enforces MFA.

Policy pulled from [AWS: Allows IAM users to manage their own credentials on the My Security Credentials page](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_aws_my-sec-creds-self-manage-no-mfa.html) but heavily modified.

Creates the following resources:

* IAM policy allowing users to manage their own security credentials and optionally enforces MFA.
* IAM group policy attachment for defining which IAM groups can manage their own credentials.
* IAM user policy attachment for defining which IAM users can manage their own credentials.

## Usage

```hcl
module "self_manage_credentials" {
  source = "dod-iac/self-manage-credentials/aws"

  iam_groups = ["engineers"]
  iam_users  = ["jane"]
}
```

## Terraform Version

Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.

Terraform 0.11 and 0.12 are not supported.

## License

This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_iam_group_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) |
| [aws_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) |
| [aws_iam_user_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy_attachment) |
| [aws_partition](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow\_access\_keys | Allow users to manage their own access keys. | `bool` | `true` | no |
| allow\_account\_aliases | Allow users to list the account aliases. | `bool` | `true` | no |
| allow\_git\_credentials | Allow users to manage their own git credentials. | `bool` | `true` | no |
| allow\_mfa\_device | Allow users to manage their own MFA device. | `bool` | `true` | no |
| allow\_signing\_certificates | Allow users to manage their own signing certificates. | `bool` | `true` | no |
| allow\_ssh\_keys | Allow users to manage their own SSH keys. | `bool` | `true` | no |
| description | The description of the AWS IAM policy. | `string` | `"Allows an IAM user to manage their own credentials"` | no |
| enforce\_mfa | Requires users to login with MFA for most AWS actions. | `bool` | `false` | no |
| iam\_groups | List of IAM groups to allow access to managing their own credentials. | `list(string)` | `[]` | no |
| iam\_users | List of IAM users to allow access to managing their own credentials. | `list(string)` | `[]` | no |
| name | Name of the AWS IAM policy. | `string` | `"self-manage-credentials"` | no |
| require\_mfa | Requires users to login with MFA when managing their own credentials. | `bool` | `true` | no |

## Outputs

No output.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
