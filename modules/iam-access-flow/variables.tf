variable "flow_vars" {
  description = "Configuration values for the Flow implementation Python."
  type        = map(string)
}


variable "iam_context_id" {
  description = "ID of the Sym runtime integration for the IAM permission context."
  type        = string
}


variable "secret_json_key" {
  description = "Name of the key that maps to the IAM API key within your Secrets Manager Secret."
  type        = string
  default     = "iam_api_token"
}

variable "secrets_settings" {
  description = "Secrets source and path for shared secret lookups."
  type = object(
    { source_id = string, path = string }
  )
}

variable "sym_environment_id" {
  description = "ID of the Sym Environment for this Flow."
  type        = string
}

variable "targets" {
  description = "List of IAM groups targets that end-users can request access to. Each object has a label and a group_name."
  type = list(object(
    { label = string, group_name = string }
  ))
}
