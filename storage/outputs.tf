# --- storage/outputs.tf ---

output "efs_id" {
  value = aws_efs_file_system.k3s_pvs_store.id
}