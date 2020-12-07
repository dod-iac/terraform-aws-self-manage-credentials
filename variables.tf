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

