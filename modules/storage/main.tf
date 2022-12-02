# --- storage/main.tf ---

resource "aws_efs_file_system" "k3s_pvs_store" {
  encrypted        = var.efs_encrypted
  performance_mode = var.efs_performance_mode
  throughput_mode  = var.efs_throughput_mode

  lifecycle_policy {
    transition_to_ia = var.efs_lifecycle_policy
  }

  tags = {
    Name = "K3s_PVs_Store"
    Tier = "NFS_Storage"
    Env  = "DevTest"
    "kubernetes.io/cluster/default" = "owned"
  }
}

resource "aws_efs_mount_target" "efs_targets" {
  count           = length(var.efs_private_subnets)
  file_system_id  = aws_efs_file_system.k3s_pvs_store.id
  subnet_id       = var.efs_private_subnets[count.index]
  security_groups = var.efs_security_groups
}