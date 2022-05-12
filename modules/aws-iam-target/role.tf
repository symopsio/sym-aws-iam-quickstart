data "aws_caller_identity" "current" {}

locals {
  account_ids        = length(var.account_ids) == 0 ? [data.aws_caller_identity.current.account_id] : var.account_ids
  account_principals = [for account_id in local.account_ids : format("arn:aws:iam::%s:root", account_id)]

  mfa_condition          = { test = "Bool", variable = "aws:MultiFactorAuthPresent", values = ["true"] }
  assume_role_conditions = var.mfa_enabled ? [local.mfa_condition] : []
}

module "target_role" {
  source  = "cloudposse/iam-role/aws"
  version = "0.16.2"

  enabled = local.create_role

  name = var.name
  path = var.path

  policy_description = var.description
  role_description   = var.description

  assume_role_conditions = local.assume_role_conditions

  principals = {
    AWS = local.account_ids
  }

  managed_policy_arns = var.managed_policy_arns

  policy_documents      = var.policy_documents
  policy_document_count = length(var.policy_documents)
}
