# --- database/outputs.tf ---

output "db_endpoint" {
  value = aws_db_instance.db.endpoint
}

output "db_name" {
  value = aws_db_instance.db.name
  sensitive = true
}