output "group_name" {
  description = "IAM Group that grants access to the target role"
  value       = aws_iam_group.this.name
}

output "role_arn" {
  description = "Target role ARN"
  value       = module.target_role.arn
}
