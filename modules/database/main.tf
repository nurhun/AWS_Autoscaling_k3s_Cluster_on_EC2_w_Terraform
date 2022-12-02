# --- database/main.tf ---


resource "aws_db_instance" "db" {
  engine                      = var.db_engine
  engine_version              = var.db_engine_version
  port                        = var.db_port
  instance_class              = var.db_instance_class
  name                        = var.db_name
  identifier                  = var.db_identifier
  username                    = var.db_username
  password                    = var.db_password
  db_subnet_group_name        = var.db_subnet_group_name
  vpc_security_group_ids      = var.db_vpc_security_group_ids
  availability_zone           = var.db_az
  multi_az                    = var.db_multi_az
  allocated_storage           = var.db_allocated_storage
  max_allocated_storage       = var.db_max_allocated_storage
  storage_type                = var.db_storage_type
  storage_encrypted           = var.db_storage_encrypted
  publicly_accessible         = var.db_public_accessibility
  copy_tags_to_snapshot       = var.db_copy_tags_to_snapshot
  skip_final_snapshot         = var.db_skip_final_snapshot
  allow_major_version_upgrade = var.db_allow_major_version_upgrade
  auto_minor_version_upgrade  = var.db_auto_minor_version_upgrade
  deletion_protection         = var.db_deletion_protection
  apply_immediately           = var.db_apply_immediately
  maintenance_window          = var.db_maintenance_window
  backup_window               = var.db_backup_window
  backup_retention_period     = var.db_backup_retention_period
  delete_automated_backups    = var.db_delete_automated_backups

  tags = {
    Name = "DB"
    Env  = "DevTest"
    Tier = "Database"
    "kubernetes.io/cluster/default" = "owned"
  }

}