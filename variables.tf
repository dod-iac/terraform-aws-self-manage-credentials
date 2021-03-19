variable "iam_groups" {
  description = "List of IAM groups to allow access to managing their own crednetials."
  type        = list(string)
  default     = []
}

variable "iam_users" {
  description = "List of IAM users to allow access to managing their own crednetials."
  type        = list(string)
  default     = []
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
