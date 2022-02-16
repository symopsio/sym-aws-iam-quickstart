# Slack Channel to send integration or runtime errors to
error_channel = "#sym-errors"

flow_vars = {
  request_channel = "#sym-requests" # Slack Channel where requests should go
}


# List of IAM groups a user can request access to.
# Each item has a label and group name.
iam_targets = [
  {
    label    = "AWS Ops Admin",
    group_name = "CHANGEME" # IAM Group name
  }
]

slack_workspace_id = "CHANGEME" # Slack Workspace where Sym is installed

# Your org slug will be provided to you by your Sym onboarding team
sym_org_slug = "CHANGEME"

# Optionally add more tags to the AWS resources we create
tags = {
  "vendor" = "symops.com"
}


# Your org slug will be provided to you by your Sym onboarding team
sym_org_slug = "moneylion-shadow"

# Optionally add more tags to the AWS resources we create
tags = {
  "vendor" = "symops.com"
}

# SYM ONLY
runtime_name = "david-iam-quickstart"
sym_account_ids = [
  "838419636750", # dev
  "859391937334", # test
  "455753951875"  # staging
]
