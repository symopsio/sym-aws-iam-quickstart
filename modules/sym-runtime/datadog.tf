resource "sym_log_destination" "datadog" {
  type = "kinesis_firehose"

  integration_id = sym_integration.runtime_context.id

  settings = {
    stream_name = module.datadog_connector.firehose_name
  }
}

/*
 * Get the runtime secret so we can pull the datadog access key from it
 */
data "aws_secretsmanager_secret_version" "this" {
  secret_id = aws_secretsmanager_secret.this.id
}

locals {
  datadog_key = jsondecode(data.aws_secretsmanager_secret_version.this.secret_string)["datadog_api_key"]
}

module "datadog_connector" {
  source  = "terraform.symops.com/symopsio/datadog-connector/sym"
  version = ">= 1.0.0"

  environment        = var.runtime_name
  datadog_access_key = local.datadog_key

  tags = {
    SymEnv = var.runtime_name
  }
}
