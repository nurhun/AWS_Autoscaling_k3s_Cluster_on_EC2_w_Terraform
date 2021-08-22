# --- root/main.tf ---


module "networking" {
  source = "./networking"

  vpc_cidr                = var.vpc_cidr
  # Will generate list of ["10.0.1.0/24", "10.0.3.0/24", "10.0.5.0/24"]
  private_subnets_cidr    = [for i in range(1, 12, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
  public_subnets_cidr     = [for i in range(2, 13, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
  db_private_subnets_cidr = [for i in range(100, 112, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
  access_ip               = var.access_ip
}


module "database" {
  source                         = "./database"
  db_engine                      = "postgres"
  db_engine_version              = "11.5"
  db_port                        = var.db_port
  db_instance_class              = "db.t2.micro"
  db_name                        = var.db_name
  db_identifier                  = var.db_identifier
  db_username                    = var.db_username
  db_password                    = var.db_password
  db_subnet_group_name           = module.networking.db_subnet_group_id
  db_vpc_security_group_ids      = [module.networking.db_sg_id]
  db_az                          = "us-east-1a"
  db_multi_az                    = false
  db_allocated_storage           = 15
  db_max_allocated_storage       = 20
  db_storage_type                = "gp2"
  db_storage_encrypted           = false
  db_public_accessibility        = false
  db_copy_tags_to_snapshot       = true
  db_skip_final_snapshot         = true
  db_allow_major_version_upgrade = false
  db_auto_minor_version_upgrade  = false
  db_deletion_protection         = false
  db_apply_immediately           = true
  db_maintenance_window          = "Fri:03:00-Fri:04:00"
  db_backup_window               = "01:00-02:00"
  db_backup_retention_period     = 3
  db_delete_automated_backups    = true
}


module "compute" {
  source = "./compute"

  asg_k3s_key_name                                  = "k3s_ec2_auth"
  asg_k3s_auth_key_path                             = pathexpand("~/.ssh/k8s_ec2_auth.pub")

  asg_k3s_control_plane_instance_type               = "t3a.medium" #2vCPU,4MiB RAM
  asg_k3s_control_plane_security_group_ids          = [module.networking.web_sg_id]
  asg_k3s_control_plane_userdata_tpl_path           = "${path.root}/masters_userdata.tpl"
  db_endpoint                                       = module.database.db_endpoint
  dbname                                            = module.database.db_name
  dbuser                                            = var.db_username
  dbpass                                            = var.db_password
  lb_dns_name                                       = module.load_balancing.k3s-lb_dns_name
  efs_id                                            = module.storage.efs_id
  aws_region                                        = var.aws_region
  k3s_control_plane_ebs_optimized                   = false
  k3s_control_plane_monitoring                      = false
  asg_k3s_control_plane_associate_public_ip_address = true

  asg_k3s_control_plane_max_count                   = "1"
  asg_k3s_control_plane_min_count                   = "1"
  asg_k3s_control_plane_desired_count               = "1"
  asg_k3s_control_plane_subnet_ids                  = module.networking.public_subnets_ids
  # asg_k3s_control_plane_lb_target_group_arns        = [module.load_balancing.k3s-masters-int-lb-tg-arn, module.load_balancing.k3s-masters-ext-lb-tg-arn]
  asg_k3s_control_plane_lb_target_group_arns        = [module.load_balancing.k3s-masters-int-lb-tg-arn]

  asg_k3s_control_plane_health_check_type           = "ELB"
  asg_k3s_control_plane_health_check_grace_period   = "120"
  asg_k3s_control_plane_default_cooldown            = "300"
  asg_k3s_control_plane_force_delete                = false
  asg_k3s_control_plane_termination_policies        = ["Default"]
  asg_k3s_control_plane_protect_from_scale_in       = false


  asg_k3s_nodes_userdata_tpl_path                   = "${path.root}/nodes_userdata.tpl"
  asg_k3s_nodes_instance_type                       = "t3a.medium"
  # asg_k3s_key_name                                  = "k3s_ec2_auth"
  asg_k3s_nodes_ebs_optimized                       = false
  asg_k3s_nodes_monitoring                          = false
  asg_k3s_nodes_security_group_ids                  = [module.networking.web_sg_id]
  asg_k3s_nodes_associate_public_ip_address         = true

  asg_k3s_nodes_max_count                           = "1"
  asg_k3s_nodes_min_count                           = "1"
  asg_k3s_nodes_desired_count                       = "1"
  asg_k3s_nodes_subnet_ids                          = module.networking.public_subnets_ids
  # asg_k3s_nodes_lb_target_group_arns                = [module.load_balancing.k3s-nodes-int-lb-tg-arn, module.load_balancing.k3s-nodes-ext-lb-tg-arn]
  asg_k3s_nodes_lb_target_group_arns                = [module.load_balancing.k3s-nodes-int-lb-tg-arn]

  asg_k3s_nodes_health_check_type                   = "ELB"
  asg_k3s_nodes_health_check_grace_period           = "120"
  asg_k3s_nodes_default_cooldown                    = "300"
  asg_k3s_nodes_force_delete                        = false
  asg_k3s_nodes_termination_policies                = ["Default"]
  asg_k3s_nodes_protect_from_scale_in               = false
}




module "load_balancing" {
  source = "./load_balancing"
  vpc_id = module.networking.vpc_id

  k3s_masters_lb_type                               = "network"
  k3s_masters_lb_internal                           = false
  k3s_masters_lb_subnets                            = module.networking.public_subnets_ids
  k3s_masters_lb_enable_cross_zone_load_balancing   = true
  k3s_masters_lb_enable_deletion_protection         = false

  k3s_masters_int_lb_tg_port                        = "6443"
  k3s_masters_int_lb_tg_protocol                    = "TCP"
  k3s_masters_int_lb_tg_hlth_ck_enabled             = true
  k3s_masters_int_lb_tg_hlth_ck_healthy_threshold   = 3
  k3s_masters_int_lb_tg_hlth_ck_unhealthy_threshold = 3
  k3s_masters_int_lb_tg_hlth_ck_interval            = 10

  k3s_masters_int_lb_listener_port                  = "6443"
  k3s_masters_int_lb_listener_protocol              = "TCP"


  k3s_nodes_lb_type                                 = "network"
  k3s_nodes_lb_internal                             = false
  k3s_nodes_lb_subnets                              = module.networking.public_subnets_ids
  k3s_nodes_lb_enable_cross_zone_load_balancing     = true
  k3s_nodes_lb_enable_deletion_protection           = false


  k3s_nodes_int_lb_tg_port                          = "10250"
  k3s_nodes_int_lb_tg_protocol                      = "TCP"
  k3s_nodes_int_lb_tg_hlth_ck_enabled               = true
  k3s_nodes_int_lb_tg_hlth_ck_healthy_threshold     = 3
  k3s_nodes_int_lb_tg_hlth_ck_unhealthy_threshold   = 3
  k3s_nodes_int_lb_tg_hlth_ck_interval              = 10

  k3s_nodes_int_lb_listener_port                    = "10256"
  k3s_nodes_int_lb_listener_protocol                = "TCP"
}


module "storage" {
  source                = "./storage"
  efs_encrypted         = true
  efs_performance_mode  = "generalPurpose"
  efs_throughput_mode   = "bursting"
  efs_lifecycle_policy  = "AFTER_7_DAYS"

  efs_private_subnets   = module.networking.private_subnets_ids
  efs_security_groups   = [module.networking.efs_sg_id]
}

