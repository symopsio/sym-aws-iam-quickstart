variable "flow_vars" {
  description = "Configuration values for the Flow implementation Python."
  type        = map(string)
}

variable "group_patterns" {
  description = "The patterns of IAM group names that this flow can modify. Both the path and name can contain wildcards."
  type = list(object(
    { path = string, name = string }
  ))
}

variable "runtime_settings" {
  description = "Runtime connector settings"
  type        = object({ role_arn = string })
}

variable "sym_environment" {
  description = "Sym Environment for this Flow."
  type        = object({ id = string, name = string })
}

variable "tags" {
  description = "Additional tags to apply to resources."
  type        = map(string)
  default     = {}
}

variable "targets" {
  description = "List of IAM groups that end-users can request access to. Each object has a label and a group_name."
  type = list(object(
    { label = string, group_name = string }
  ))
}

