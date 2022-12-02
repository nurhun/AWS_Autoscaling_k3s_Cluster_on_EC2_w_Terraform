# --- compute/variables.tf ---

variable "asg_k3s_key_name" {
  type        = string
  description = "The name for the key pair."
}


variable "asg_k3s_auth_key_path" {
  type = string
  # default = ""
  description = "The path to the public key generated on our local machine."
}


variable "asg_k3s_control_plane_instance_type" {}


variable "asg_k3s_control_plane_security_group_ids" {}


variable "asg_k3s_control_plane_userdata_tpl_path" {
  type        = string
  description = "path of userdata.tpl file in our main root directory"
}

variable "db_endpoint" {}

variable "dbname" {}

variable "dbuser" {}

variable "dbpass" {}

variable "lb_dns_name" {}

variable "aws_region" {}

variable "efs_id" {}

variable "k3s_control_plane_ebs_optimized" {
  description = "EBS–optimized instance provides additional, dedicated capacity for Amazon EBS I/O"
}


variable "k3s_control_plane_monitoring" {
  type        = string
  description = " If true, the launched EC2 instance will have detailed monitoring enabled."
}


variable "asg_k3s_control_plane_associate_public_ip_address" {
  type        = string
  description = "Whether to associate a public IP address with an instance in a VPC."
}


# variable "asg_k3s_control_plane_placement_group" {
#   type = string
#   # default = "spread"
#   description = <<EOF
#   "You can use placement groups to influence the placement of instances across underlying hardware"
#   "There is no charge for creating a placement group. Can be "cluster", "partition" or "spread"."
#   "Cluster – packs instances close together inside an Availability Zone."
#   "Partition – spreads your instances across logical partitions."
#   "Spread – strictly places a small group of instances across distinct underlying hardware to reduce correlated failures. this is default." 
#   EOF
# }



# variable "ec2_root_volume_type" {
#     description = "standard, gp2, gp3, io1, io2, sc1, or st1. Defaults to gp2."
# }

# variable "ec2_root_volume_encrypted" {
#     description = "Whether to enable volume encryption. Defaults to false."
# }

# variable "ec2_root_throughput" {
#     description = "This is only valid for volume_type of gp3. hroughput measures the number of bits read or written per second."
# }

# variable "ec2_root_iops" {
#     description = "Only valid for volume_type of io1, io2 or gp3. IOPS measures the number of read and write operations per second."
# }

# variable "ec2_root_delete_on_termination" {
#     description = "Whether the volume should be destroyed on instance termination. Defaults to true."
# }


# variable "ec2_ebs_device_names" {
#     type = list(map(string))
#     # default = [
#     #     "/dev/sdx",
#     #     "/dev/sdy",
#     # ]
# }


# variable "ec2_ebs_availability_zone" {}

# variable "ec2_ebs_size" {}


variable "asg_k3s_control_plane_max_count" {}

variable "asg_k3s_control_plane_min_count" {}

variable "asg_k3s_control_plane_desired_count" {
  description = "The number of Amazon EC2 instances that should be running in the group."
}


variable "asg_k3s_control_plane_subnet_ids" {
  description = "A list of subnet IDs to launch resources in. Subnets automatically determine which availability zones the group will reside. Conflicts with availability_zones."
}


variable "asg_k3s_control_plane_lb_target_group_arns" {
  description = "A set of aws_alb_target_group ARNs, for use with Application or Network Load Balancing."
}


variable "asg_k3s_control_plane_health_check_type" {
  # default = "ELB"
  description = "EC2 or ELB. Controls how health checking is done."
}


variable "asg_k3s_control_plane_health_check_grace_period" {
  # default = 180
  description = "Time (in seconds) after instance comes into service before checking health. Default: 300"
}


variable "asg_k3s_control_plane_force_delete" {
  description = " Allows deleting the Auto Scaling Group without waiting for all instances in the pool to terminate. Normally, Terraform drains all the instances before deleting the group."
}


variable "asg_k3s_control_plane_termination_policies" {
  # default = "Default"
  description = "termination_policies (Optional) A list of policies to decide how the instances in the Auto Scaling Group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, OldestLaunchTemplate, AllocationStrategy, Default."
}


variable "asg_k3s_control_plane_default_cooldown" {
  # default = "180"
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start."
}


variable "asg_k3s_control_plane_protect_from_scale_in" {
  # default = false
  description = "If enabled, newly launched instances will be protected from scale in by default. It won't remove instances added by scale out."
}

variable "asg_k3s_nodes_userdata_tpl_path" {}
variable "asg_k3s_nodes_instance_type" {}
# variable "asg_k3s_key_name" {}
variable "asg_k3s_nodes_ebs_optimized" {}
variable "asg_k3s_nodes_monitoring" {}
variable "asg_k3s_nodes_security_group_ids" {}
variable "asg_k3s_nodes_associate_public_ip_address" {}
variable "asg_k3s_nodes_max_count" {}
variable "asg_k3s_nodes_min_count" {}
variable "asg_k3s_nodes_desired_count" {}
variable "asg_k3s_nodes_subnet_ids" {}
variable "asg_k3s_nodes_lb_target_group_arns" {}
variable "asg_k3s_nodes_health_check_type" {}
variable "asg_k3s_nodes_health_check_grace_period" {}
variable "asg_k3s_nodes_default_cooldown" {}
variable "asg_k3s_nodes_force_delete" {}
variable "asg_k3s_nodes_termination_policies" {}
variable "asg_k3s_nodes_protect_from_scale_in" {}
