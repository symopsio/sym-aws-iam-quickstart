locals {
  create_role  = length(var.target_role_arns) == 0
  target_roles = local.create_role ? [module.target_role.arn] : var.target_role_arns
}

resource "aws_iam_group" "this" {
  name = var.name
  path = var.path
}

resource "aws_iam_policy" "this" {
  name        = var.name
  description = var.description
  path        = var.path
  policy      = data.aws_iam_policy_document.assume_role.json

  tags = var.tags
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = local.target_roles
  }
}

resource "aws_iam_group_policy_attachment" "this" {
  group      = aws_iam_group.this.id
  policy_arn = aws_iam_policy.this.id
}
