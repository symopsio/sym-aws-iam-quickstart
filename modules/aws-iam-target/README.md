# aws-iam-target

A helper module that creates an IAM Group suitable for integrating with a Sym access flow. If you supply the `policy_documents` or `managed_policy_arns` properties, then the module creates a Role in the same account that the Group can assume. If you supply the `target_role_arns` property, then the module skips Role creation and just grants members to assume cross-account roles.
