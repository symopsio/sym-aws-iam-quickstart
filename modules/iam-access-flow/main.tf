locals {
  flow_name = "iam_access"
}

# The Flow that grants users access to IAM targets.
resource "sym_flow" "this" {
  name  = local.flow_name
  label = "IAM Access"

  template = "sym:template:approval:1.0.0"

  implementation = "${path.module}/impl.py"

  environment_id = var.sym_environment.id

  vars = var.flow_vars

  params = {
    strategy_id = sym_strategy.this.id

    prompt_fields_json = jsonencode(
      [
        {
          name     = "reason"
          type     = "string"
          required = true
        }
      ]
    )
  }
}

# The Strategy your Flow uses to manage target AWS IAM groups.
resource "sym_strategy" "this" {
  type = "aws_iam"

  name           = local.flow_name
  integration_id = sym_integration.iam_context.id
  targets        = [for target in var.targets : sym_target.targets[target["group_name"]].id]
}

# The target IAM groups that your Sym Strategy manages access to.
resource "sym_target" "targets" {
  for_each = { for target in var.targets : target["group_name"] => target["label"] }

  type = "aws_iam_group"

  name  = "${local.flow_name}-${each.key}"
  label = each.value

  settings = {
    iam_group = each.key
  }
}

# The AWS IAM Resources that enable Sym to manage IAM Groups
module "iam_connector" {
  source  = "terraform.symops.com/symopsio/iam-connector/sym"
  version = ">= 1.2.0"

  environment       = local.flow_name
  runtime_role_arns = [var.runtime_settings.role_arn]
}

# The Integration your Strategy uses to manage IAM Groups
resource "sym_integration" "iam_context" {
  type = "permission_context"
  name = local.flow_name

  external_id = module.iam_connector.settings.account_id
  settings    = module.iam_connector.settings
}
