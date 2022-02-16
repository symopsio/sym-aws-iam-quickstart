output "prod_environment_id" {
  description = "Sym Prod Environment ID"
  value       = sym_environment.prod.id
}

output "sandbox_environment_id" {
  description = "Sym Sandbox Environment ID"
  value       = sym_environment.sandbox.id
}

output "iam_context_id" {
  description = "Sym IAM Runtime Context ID"
  value       = sym_integration.iam_context.id
}


output "secrets_settings" {
  description = "Secrets source and path for shared secret lookups"
  value = {
    source_id = sym_secrets.this.id
    path      = local.resolved_secret_path
  }
}
