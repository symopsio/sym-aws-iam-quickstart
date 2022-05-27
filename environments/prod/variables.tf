variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "error_channel" {
  description = "The error channel to use to surface Sym errors."
  type        = string
  default     = "#sym-errors"
}

variable "example_target_enabled" {
  description = "Whether to create an example IAM target group and role"
  type        = bool
  default     = false
}

variable "flow_vars" {
  description = "Configuration values for the Flow implementation Python"
  type        = map(string)
  default     = {}
}

variable "iam_group_patterns" {
  description = "The patterns of IAM group names that this flow can modify. Both the path and name can contain wildcards."
  type = list(object(
    { path = string, name = string }
  ))
}

variable "iam_targets" {
  description = "List of IAM group targets that end-users can request access to. Each object has a label and a group_name. Must either enable the example target or supply a listing here."
  type = list(object(
    { label = string, group_name = string }
  ))
  default = []
}

variable "runtime_name" {
  description = "Name to assign to the Sym Runtime and its associated resources."
  type        = string
  default     = "prod"
}

variable "slack_workspace_id" {
  description = "The Slack Workspace ID to use for your Slack integration"
  type        = string
}

variable "sym_account_ids" {
  description = "List of account ids that can assume the Sym runtime role. By default, only Sym production accounts can assume the runtime role."
  type        = list(string)
  default     = ["803477428605"]
}

variable "sym_org_slug" {
  description = "Sym org slug for your org"
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to resources"
  type        = map(string)
  default     = {}
}
