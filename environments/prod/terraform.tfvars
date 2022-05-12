# Slack Channel to send integration or runtime errors to
error_channel = "#sym-errors"

# Whether or not to create an example IAM target for testing
example_target_enabled = false

flow_vars = {
  # Slack Channel where requests should go
  request_channel = "#sym-requests"

  # Optional safelist of users that can approve requests
  approvers = "foo@myco.com,bar@myco.com"
}

# The patterns of IAM group names that this flow can modify.
# Both the path and name can contain wildcards.
iam_group_patterns = [
  { path = "/sym/", name = "*" }
]

# List of IAM groups a user can request access to.
# Each item has a label and group name.
#iam_targets = [
#  {
#    label      = "AWS Ops Admin",
#    group_name = "CHANGEME" # IAM Group name
#  }
#]

# Slack Workspace where Sym is installed
slack_workspace_id = "CHANGEME"

# Your org slug will be provided to you by your Sym onboarding team
sym_org_slug = "CHANGEME"

# Optionally add more tags to the AWS resources we create
tags = {
  "vendor" = "symops.com"
}
