/**
 * ## Usage
 *
 * Configures IAM policy to allow users to manage their own credentials.
 *
 * Policy pulled from [AWS: Allows IAM users to manage their own credentials on the My Security Credentials page](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_aws_my-sec-creds-self-manage-no-mfa.html)
 *
 * Creates the following resources:
 *
 * * IAM policy allowing users to manage their own security credentials.
 * * IAM group policy attachment for defining which IAM groups can manage their own credentials.
 * * IAM user policy attachment for defining which IAM users can manage their own credentials.
 *
 * ## Usage
 *
 * ```hcl
 * module "self_manage_credentials" {
 *   source = "dod-iac/self-manage-credentials/aws"
 *
 *   iam_groups = ["engineers"]
 *   iam_users  = ["jane"]
 * }
 * ```
 *
 * ## Terraform Version
 *
 * Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.
 *
 * Terraform 0.11 and 0.12 are not supported.
 *
 * ## License
 *
 * This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.
 */

data "aws_partition" "current" {
}

data "aws_iam_policy_document" "main" {
  statement {
    sid    = "AllowViewAccountInfo"
    effect = "Allow"
    actions = [
      "iam:GetAccountPasswordPolicy",
      "iam:GetAccountSummary",
    ]
    resources = ["*"]
  }
  statement {
    sid    = "AllowManageOwnPasswords"
    effect = "Allow"
    actions = [
      "iam:ChangePassword",
      "iam:GetUser",
    ]
    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }
  statement {
    sid    = "AllowManageOwnAccessKeys"
    effect = "Allow"
    actions = [
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey",
      "iam:ListAccessKeys",
      "iam:UpdateAccessKey",
    ]
    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }
  statement {
    sid    = "AllowManageOwnSigningCertificates"
    effect = "Allow"
    actions = [
      "iam:DeleteSigningCertificate",
      "iam:ListSigningCertificates",
      "iam:UpdateSigningCertificate",
      "iam:UploadSigningCertificate",
    ]
    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }
  statement {
    sid    = "AllowManageOwnSSHPublicKeys"
    effect = "Allow"
    actions = [
      "iam:DeleteSSHPublicKey",
      "iam:GetSSHPublicKey",
      "iam:ListSSHPublicKeys",
      "iam:UpdateSSHPublicKey",
      "iam:UploadSSHPublicKey",
    ]
    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }
  statement {
    sid    = "AllowManageOwnGitCredentials"
    effect = "Allow"
    actions = [
      "iam:CreateServiceSpecificCredential",
      "iam:DeleteServiceSpecificCredential",
      "iam:ListServiceSpecificCredentials",
      "iam:ResetServiceSpecificCredential",
      "iam:UpdateServiceSpecificCredential",
    ]
    resources = ["arn:aws:iam::*:user/$${aws:username}"]
  }
}

resource "aws_iam_policy" "main" {
  name        = "self-manage-credentials"
  path        = "/"
  description = "Allows an IAM user to manage their own credentials"
  policy      = data.aws_iam_policy_document.main.json
}

resource "aws_iam_group_policy_attachment" "main" {
  count      = length(var.iam_groups)
  group      = element(var.iam_groups, count.index)
  policy_arn = aws_iam_policy.main.arn
}

resource "aws_iam_user_policy_attachment" "main" {
  count      = length(var.iam_users)
  user       = element(var.iam_users, count.index)
  policy_arn = aws_iam_policy.main.arn
}
