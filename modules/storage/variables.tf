# --- storage/variables.tf ---

variable "efs_encrypted" {}

variable "efs_performance_mode" {
  description = "The file system performance mode. Can be either 'generalPurpose' or 'maxIO' (Default: 'generalPurpose')."
}

variable "efs_throughput_mode" {
  description = "Defaults to bursting. Valid values: bursting, provisioned."
}

variable "efs_lifecycle_policy" {
  description = "A value that describes the period of time that a file is not accessed, after which it transitions to the IA storage class. Valid Values: AFTER_7_DAYS | AFTER_14_DAYS | AFTER_30_DAYS | AFTER_60_DAYS | AFTER_90_DAYS"
}

variable "efs_private_subnets" {}

variable "efs_security_groups" {}