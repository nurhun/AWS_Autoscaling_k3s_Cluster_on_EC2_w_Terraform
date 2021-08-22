# --- database/variables.tf ---

variable "db_engine" {
  type = string
  # default = "mysql"
  # default = "postgres"
}


variable "db_engine_version" {
  type = string
  # default     = "5.7.33"
  # default     = "11.5"
  description = <<EOF
  "k3s MySQL (certified against version 5.7)
   reference: https://rancher.com/docs/k3s/latest/en/installation/datastore/#datastore-endpoint-format-and-functionality"
   EOF
}


variable "db_port" {
  type = number
  # default = 5432
  # default = 3306
}


variable "db_instance_class" {
  type = string
  # default = "db.t3.micro"
}


variable "db_name" {
  type = string
  # default = "db"
}


variable "db_identifier" {
  type    = string
  default = "db"
}


variable "db_username" {
  type      = string
  sensitive = true
}


variable "db_password" {
  type      = string
  sensitive = true
}


variable "db_subnet_group_name" {
  type        = string
  description = "aws_db_subnet_group.db_subnet[db_sg]"
}


variable "db_vpc_security_group_ids" {
  type = list(any)
}


variable "db_az" {
  type = string
  # default = ""
}


variable "db_multi_az" {
  # default = false
}


variable "db_allocated_storage" {
  type = number
  # default = 15
}


variable "db_max_allocated_storage" {
  type = number
  # default = 20
}


variable "db_storage_type" {
  type = string
  # default = "gp2"
  description = <<EOF
    One of "standard" (magnetic), "gp2" (general purpose SSD), or "io1" (provisioned IOPS SSD).
    The default is "io1" if iops is specified, "gp2" if not.
  EOF
}


variable "db_storage_encrypted" {
  type = string
  # default = false
}


variable "db_public_accessibility" {
  # default = false
}


variable "db_copy_tags_to_snapshot" {
  # default = true  
}


variable "db_skip_final_snapshot" {
  # default = true
}


variable "db_allow_major_version_upgrade" {
  # default = false 
}

variable "db_auto_minor_version_upgrade" {
  # default = false
}

variable "db_deletion_protection" {
  default = false
}


variable "db_apply_immediately" {
  # default = true
}


variable "db_maintenance_window" {
  type = string
  # default = "Fri:03:00-Fri:04:00" 
}


variable "db_backup_window" {
  type = string
  # default = "01:00-02:00"
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Must not overlap with maintenance_window."
}


variable "db_backup_retention_period" {
  type = number
  # default = 7
  description = "The days to retain backups for. Must be between 0 and 35. Must be greater than 0 if the database is used as a source for a Read Replica."
}


variable "db_delete_automated_backups" {
  type = string
  # default = true
  description = "Specifies whether to remove automated backups immediately after the DB instance is deleted. Default is true."
}