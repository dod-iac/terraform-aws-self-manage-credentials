variable "allow_account_aliases" {
  type        = bool
  description = "Allow users to list the account aliases."
  default     = true
}

variable "allow_access_keys" {
  type        = bool
  description = "Allow users to manage their own access keys."
  default     = true
}

variable "allow_git_credentials" {
  type        = bool
  description = "Allow users to manage their own git credentials."
  default     = true
}

variable "allow_mfa_device" {
  type        = bool
  description = "Allow users to manage their own MFA device."
  default     = true
}

variable "allow_signing_certificates" {
  type        = bool
  description = "Allow users to manage their own signing certificates."
  default     = true
}

variable "allow_ssh_keys" {
  type        = bool
  description = "Allow users to manage their own SSH keys."
  default     = true
}

variable "description" {
  type        = string
  description = "The description of the AWS IAM policy."
  default     = "Allows an IAM user to manage their own credentials"
}

variable "enforce_mfa" {
  type        = bool
  description = "Requires users to login with MFA for most AWS actions."
  default     = false
}

variable "iam_groups" {
  description = "List of IAM groups to allow access to managing their own credentials."
  type        = list(string)
  default     = []
}

variable "iam_users" {
  description = "List of IAM users to allow access to managing their own credentials."
  type        = list(string)
  default     = []
}

variable "name" {
  type        = string
  description = "Name of the AWS IAM policy."
  default     = "self-manage-credentials"
}

variable "require_mfa" {
  type        = bool
  description = "Requires users to login with MFA when managing their own credentials."
  default     = true
}
