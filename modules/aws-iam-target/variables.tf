variable "account_ids" {
  description = "List of account IDs that the target role trusts. If unspecified, the current account ID is used."
  type        = list(string)
  default     = []
}

variable "description" {
  description = "Description for IAM Group and Role"
  type        = string
}

variable "managed_policy_arns" {
  description = "Optional managed policies to add to the target role"
  type        = list(string)
  default     = []
}

variable "mfa_enabled" {
  description = "Whether to apply an MFA constraint to assuming this target role"
  type        = bool
  default     = false
}

variable "name" {
  description = "Name for IAM Group and Role"
  type        = string
}

variable "path" {
  description = "Path for IAM resources (Group, Role, Policy)"
  type        = string
  default     = "/sym/"
}

variable "policy_documents" {
  description = "IAM policy documents to attach to the target role"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "target_role_arns" {
  description = "List of role ARNs this target group can assume. If specified, then no role is created"
  type        = list(string)
  default     = []
}
