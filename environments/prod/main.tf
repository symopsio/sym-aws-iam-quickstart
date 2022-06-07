provider "aws" {
  region = var.aws_region
}

provider "sym" {
  org = var.sym_org_slug
}

data "aws_caller_identity" "current" {}

# You cannot create a new backend by simply defining this and then
# immediately proceeding to "terraform apply". The S3 backend must
# be bootstrapped according to the simple yet essential procedure in
# https://github.com/cloudposse/terraform-aws-tfstate-backend#usage
module "terraform_state_backend" {
  source     = "cloudposse/tfstate-backend/aws"
  version    = "0.38.1"
  namespace  = "sym"
  name       = "tfstate"
  attributes = [data.aws_caller_identity.current.account_id]

  terraform_backend_config_file_path = "."
  terraform_backend_config_file_name = "backend.tf"

  terraform_state_file = "prod/terraform.tfstate"
  force_destroy        = false
}


# A Sym Runtime that executes your Flows.
module "sym_runtime" {
  source = "../../modules/sym-runtime"

  error_channel      = var.error_channel
  runtime_name       = var.runtime_name
  slack_workspace_id = var.slack_workspace_id
  sym_account_ids    = var.sym_account_ids
  tags               = var.tags
}

module "example_target" {
  count  = var.example_target_enabled ? 1 : 0
  source = "../../modules/aws-iam-target"

  description         = "Example IAM ReadOnly Target"
  name                = "sym-readonly-${var.runtime_name}"
  managed_policy_arns = ["arn:aws:iam::aws:policy/IAMReadOnlyAccess"]

  tags = var.tags
}

locals {
  iam_targets = var.example_target_enabled ? concat([
    {
      group_name = module.example_target[0].group_name,
      label      = "Example"
    }
  ], var.iam_targets) : var.iam_targets
}


# A Flow that can manage access to a list of IAM target groups.
module "aws_iam_flow" {
  source = "../../modules/aws-iam-flow"

  flow_vars        = var.flow_vars
  group_patterns   = var.iam_group_patterns
  runtime_settings = module.sym_runtime.runtime_settings
  sym_environment  = module.sym_runtime.environment
  targets          = local.iam_targets
  tags             = var.tags
}
