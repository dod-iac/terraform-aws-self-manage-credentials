## Usage

Configures IAM policy to allow users to manage their own credentials.

Policy pulled from [AWS: Allows IAM users to manage their own credentials on the My Security Credentials page](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_aws_my-sec-creds-self-manage-no-mfa.html)

Creates the following resources:

* IAM policy allowing users to manage their own security credentials.
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
| terraform | ~> 0.13.0 |
| aws | ~> 3 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| iam\_groups | List of IAM groups to allow access to managing their own crednetials. | `list(string)` | `[]` | no |
| iam\_users | List of IAM users to allow access to managing their own crednetials. | `list(string)` | `[]` | no |

## Outputs

No output.

