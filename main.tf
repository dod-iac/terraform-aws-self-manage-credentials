/**
 * ## Usage
 *
 * Configures IAM policy to allow users to manage their own credentials and optionally enforces MFA.
 *
 * Policy pulled from [AWS: Allows IAM users to manage their own credentials on the My Security Credentials page](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_aws_my-sec-creds-self-manage-no-mfa.html) but heavily modified.
 *
 * Creates the following resources:
 *
 * * IAM policy allowing users to manage their own security credentials and optionally enforces MFA.
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

data "aws_partition" "current" {}

data "aws_iam_policy_document" "main" {
  dynamic "statement" {
    for_each = var.allow_account_aliases ? [var.allow_account_aliases] : []
    content {
      sid    = "AllowListAccountAliases"
      effect = "Allow"
      actions = [
        "iam:ListAccountAliases",
      ]
      resources = ["*"]
    }
  }
  statement {
    sid    = "AllowGetAccountPasswordPolicy"
    effect = "Allow"
    actions = [
      "iam:GetAccountPasswordPolicy",
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
    resources = ["arn:${data.aws_partition.current.partition}:iam::*:user/$${aws:username}"]
    dynamic "condition" {
      for_each = var.require_mfa ? [true] : []
      content {
        test     = "Bool"
        variable = "aws:MultiFactorAuthPresent"
        values   = ["true"]
      }
    }
  }
  dynamic "statement" {
    for_each = var.allow_access_keys ? [var.allow_access_keys] : []
    content {
      sid    = "AllowManageOwnAccessKeys"
      effect = "Allow"
      actions = [
        "iam:CreateAccessKey",
        "iam:DeleteAccessKey",
        "iam:ListAccessKeys",
        "iam:UpdateAccessKey"
      ]
      resources = [
        format("arn:%s:iam::*:user/$${aws:username}", data.aws_partition.current.partition)
      ]
      dynamic "condition" {
        for_each = var.require_mfa ? [true] : []
        content {
          test     = "Bool"
          variable = "aws:MultiFactorAuthPresent"
          values   = ["true"]
        }
      }
    }
  }
  dynamic "statement" {
    for_each = var.allow_signing_certificates ? [var.allow_signing_certificates] : []
    content {
      sid    = "AllowManageOwnSigningCertificates"
      effect = "Allow"
      actions = [
        "iam:DeleteSigningCertificate",
        "iam:ListSigningCertificates",
        "iam:UpdateSigningCertificate",
        "iam:UploadSigningCertificate",
      ]
      resources = [
        format("arn:%s:iam::*:user/$${aws:username}", data.aws_partition.current.partition)
      ]
      dynamic "condition" {
        for_each = var.require_mfa ? [true] : []
        content {
          test     = "Bool"
          variable = "aws:MultiFactorAuthPresent"
          values   = ["true"]
        }
      }
    }
  }
  dynamic "statement" {
    for_each = var.allow_ssh_keys ? [var.allow_ssh_keys] : []
    content {
      sid    = "AllowManageOwnSSHPublicKeys"
      effect = "Allow"
      actions = [
        "iam:DeleteSSHPublicKey",
        "iam:GetSSHPublicKey",
        "iam:ListSSHPublicKeys",
        "iam:UpdateSSHPublicKey",
        "iam:UploadSSHPublicKey",
      ]
      resources = [
        format("arn:%s:iam::*:user/$${aws:username}", data.aws_partition.current.partition)
      ]
      dynamic "condition" {
        for_each = var.require_mfa ? [true] : []
        content {
          test     = "Bool"
          variable = "aws:MultiFactorAuthPresent"
          values   = ["true"]
        }
      }
    }
  }
  dynamic "statement" {
    for_each = var.allow_git_credentials ? [var.allow_git_credentials] : []
    content {
      sid    = "AllowManageOwnGitCredentials"
      effect = "Allow"
      actions = [
        "iam:CreateServiceSpecificCredential",
        "iam:DeleteServiceSpecificCredential",
        "iam:ListServiceSpecificCredentials",
        "iam:ResetServiceSpecificCredential",
        "iam:UpdateServiceSpecificCredential",
      ]
      resources = [
        format("arn:%s:iam::*:user/$${aws:username}", data.aws_partition.current.partition)
      ]
      dynamic "condition" {
        for_each = var.require_mfa ? [true] : []
        content {
          test     = "Bool"
          variable = "aws:MultiFactorAuthPresent"
          values   = ["true"]
        }
      }
    }
  }
  dynamic "statement" {
    for_each = var.allow_mfa_device ? [var.allow_mfa_device] : []
    content {
      sid    = "AllowListVirtualMFADevices"
      effect = "Allow"
      actions = [
        "iam:ListVirtualMFADevices"
      ]
      resources = ["arn:${data.aws_partition.current.partition}:iam::*:mfa/*"]
    }
  }
  dynamic "statement" {
    for_each = var.allow_mfa_device ? [var.allow_mfa_device] : []
    content {
      sid    = "AllowManageMFADevice"
      effect = "Allow"
      actions = [
        "iam:ListMFADevices",
        "iam:EnableMFADevice",
        "iam:ResyncMFADevice"
      ]
      resources = ["arn:${data.aws_partition.current.partition}:iam::*:user/$${aws:username}"]
    }
  }
  dynamic "statement" {
    for_each = var.allow_mfa_device ? [var.allow_mfa_device] : []
    content {
      sid    = "AllowDeactivateMFADevice"
      effect = "Allow"
      actions = [
        "iam:DeactivateMFADevice"
      ]
      resources = ["arn:${data.aws_partition.current.partition}:iam::*:user/$${aws:username}"]
      # This action requires MFA to be used.  If MFA was not required,
      # an attacker with a compromised password could disable MFA and change it.
      condition {
        test     = "Bool"
        variable = "aws:MultiFactorAuthPresent"
        values   = ["true"]
      }
    }
  }
  dynamic "statement" {
    for_each = var.allow_mfa_device ? [var.allow_mfa_device] : []
    content {
      sid    = "AllowManageVirtualMFADevice"
      effect = "Allow"
      actions = [
        # If an MFA device does not exist yet, then your session won't have MFA set.
        "iam:CreateVirtualMFADevice",
        # You must deactivate a user's MFA device before you can delete it,
        # therefore, this statement does not need a MultiFactorAuthPresent condition.
        "iam:DeleteVirtualMFADevice"
      ]
      resources = ["arn:${data.aws_partition.current.partition}:iam::*:mfa/$${aws:username}"]
    }
  }

  dynamic "statement" {
    for_each = var.enforce_mfa ? [var.enforce_mfa] : []
    content {
      sid    = "BlockMostAccessUnlessSignedInWithMFA"
      effect = "Deny"
      not_actions = [
        # IAM Actions
        "iam:ListAccountAliases",
        # MFA Actions
        "iam:CreateVirtualMFADevice",
        "iam:DeleteVirtualMFADevice",
        "iam:ListVirtualMFADevices",
        "iam:EnableMFADevice",
        "iam:ResyncMFADevice",
        "iam:ListMFADevices",
        # STS Actions
        "sts:GetSessionToken",
      ]
      resources = ["*"]
      condition {
        test     = "BoolIfExists"
        variable = "aws:MultiFactorAuthPresent"
        values   = ["false"]
      }
    }
  }
}

resource "aws_iam_policy" "main" {
  name        = var.name
  path        = "/"
  description = var.description
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
