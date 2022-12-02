# --- Load_Balancing/variables.tf ---

variable "vpc_id" {}

variable "k3s_masters_lb_type" {}

variable "k3s_masters_lb_internal" {}

variable "k3s_masters_lb_subnets" {}

variable "k3s_masters_lb_enable_cross_zone_load_balancing" {
  type        = string
  description = <<EOF
   "If true, cross-zone load balancing of the load balancer will be enabled.
   This is a network load balancer feature.
   Defaults to false."
  EOF
}

variable "k3s_masters_lb_enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false"
}


variable "k3s_masters_int_lb_tg_port" {}

variable "k3s_masters_int_lb_tg_protocol" {}

variable "k3s_masters_int_lb_tg_hlth_ck_enabled" {}

variable "k3s_masters_int_lb_tg_hlth_ck_healthy_threshold" {}

variable "k3s_masters_int_lb_tg_hlth_ck_unhealthy_threshold" {}

variable "k3s_masters_int_lb_tg_hlth_ck_interval" {}


variable "k3s_masters_int_lb_listener_port" {}

variable "k3s_masters_int_lb_listener_protocol" {}




variable "k3s_nodes_lb_type" {}

variable "k3s_nodes_lb_internal" {}

variable "k3s_nodes_lb_subnets" {}

variable "k3s_nodes_lb_enable_cross_zone_load_balancing" {
  type        = string
  description = <<EOF
   "If true, cross-zone load balancing of the load balancer will be enabled.
   This is a network load balancer feature.
   Defaults to false."
  EOF
}

variable "k3s_nodes_lb_enable_deletion_protection" {}


variable "k3s_nodes_int_lb_tg_port" {}

variable "k3s_nodes_int_lb_tg_protocol" {}

variable "k3s_nodes_int_lb_tg_hlth_ck_enabled" {}

variable "k3s_nodes_int_lb_tg_hlth_ck_healthy_threshold" {}

variable "k3s_nodes_int_lb_tg_hlth_ck_unhealthy_threshold" {}

variable "k3s_nodes_int_lb_tg_hlth_ck_interval" {}


variable "k3s_nodes_int_lb_listener_port" {}

variable "k3s_nodes_int_lb_listener_protocol" {}