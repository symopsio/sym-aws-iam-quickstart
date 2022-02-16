provider "aws" {
  region = var.aws_region
}

provider "sym" {
  org = var.sym_org_slug
}

# Creates a Sym Runtime that can execute your Flows.
module "sym_runtime" {
  source = "../modules/sym-runtime"

  error_channel      = var.error_channel
  runtime_name       = var.runtime_name
  slack_workspace_id = var.slack_workspace_id
  sym_account_ids    = var.sym_account_ids
  tags               = var.tags
}

# A Flow that can manage access to a list of IAM target groups.
module "iam_access_flow" {
  source = "../modules/iam-access-flow"

  flow_vars          = var.flow_vars
  secrets_settings   = module.sym_runtime.secrets_settings
  sym_environment_id = module.sym_runtime.prod_environment_id
  iam_context_id     = module.sym_runtime.iam_context_id
  targets            = var.iam_targets
}
