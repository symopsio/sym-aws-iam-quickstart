# Creates an AWS IAM Role that a Sym runtime can use for execution
module "runtime_connector" {
  source  = "terraform.symops.com/symopsio/runtime-connector/sym"
  version = ">= 1.1.0"

  addons          = ["aws/secretsmgr"]
  environment     = var.runtime_name
  sym_account_ids = var.sym_account_ids

  tags = var.tags
}

# Creates AWS IAM Role that a Sym runtime assumes to modify IAM Groups
module "iam_connector" {
  source  = "terraform.symops.com/symopsio/iam-connector/sym"
  version = ">= 1.2.0"

  environment       = var.runtime_name
  runtime_role_arns = [module.runtime_connector.settings["role_arn"]]
}


# The base permissions that a workflow has access to
resource "sym_integration" "runtime_context" {
  type = "permission_context"
  name = "runtime-${var.runtime_name}"

  external_id = module.runtime_connector.settings.account_id
  settings    = module.runtime_connector.settings
}

# Permission context for working with AWS IAM
resource "sym_integration" "iam_context" {
  type = "permission_context"

  name        = "iam-${var.runtime_name}"
  label       = "IAM Permission Context"
  settings    = module.iam_connector.settings
  external_id = module.iam_connector.settings.account_id
}

# Declares a runtime where workflows can execute
resource "sym_runtime" "this" {
  name       = var.runtime_name
  context_id = sym_integration.runtime_context.id
}

# An integration with Slack
resource "sym_integration" "slack" {
  type = "slack"
  name = var.runtime_name

  external_id = var.slack_workspace_id
}
