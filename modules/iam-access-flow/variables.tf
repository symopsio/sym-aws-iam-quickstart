variable "flow_vars" {
  description = "Configuration values for the Flow implementation Python."
  type        = map(string)
}

variable "runtime_settings" {
  description = "Runtime connector settings"
  type        = object({ role_arn = string })
}

variable "sym_environment" {
  description = "Sym Environment for this Flow."
  type        = object({ id = string, name = string })
}

variable "targets" {
  description = "List of IAM groups targets that end-users can request access to. Each object has a label and a group_name."
  type = list(object(
    { label = string, group_name = string }
  ))
}

variable "tags" {
  description = "Additional tags to apply to resources."
  type        = map(string)
  default     = {}
}
