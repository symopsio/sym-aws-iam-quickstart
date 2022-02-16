locals {
  flow_name = "sym_iam_access"
}

# The Flow that grants users access to IAM targets.
resource "sym_flow" "this" {
  name  = local.flow_name
  label = "IAM Access"

  template = "sym:template:approval:1.0.0"

  implementation = "${path.module}/impl.py"

  environment_id = var.sym_environment_id

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

# The Strategy your Flow uses to manage target IAM groups.
resource "sym_strategy" "this" {
  type = "aws_iam"

  name           = local.flow_name
  integration_id = var.iam_context_id
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
