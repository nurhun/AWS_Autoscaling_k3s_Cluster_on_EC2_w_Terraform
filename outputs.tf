# --- root/outputs.tf ---

# output "preferred_public_subnet_az" {
#   value = module.networking.preferred_public_subnet_az
# }

# output "azs_no" {
#   value = module.networking.azs_no
# }

# output "azs" {
#   value = module.networking.azs
# }

# output "subnet_id" {
#   value = module.networking.public_subnets
# }

# output "instances_ids" {
#   value = module.compute.instances_ids
# }

# output "instances_ips" {
#   value = module.compute.instances_ips
# }

# output "instances_private_ips" {
#   value = module.compute.instances_private_ips
# }

# output "lb_dns_name" {
#   value = module.load_balancing.lb_dns_name
# }

output "k3s-masters-lb_dns_name" {
  value = module.load_balancing.k3s-lb_dns_name
}

# locals {
#   lb_dns_name = aws_lb.k3s-lb.dns_name
# }

# output "k3s-lb_private_ip" {
#   value = module.load_balancing.k3s-lb_private_ip
# }

output "ec2_instances_public_ips" {
  value = module.compute.ec2_instances_public_ips
}

# output "k3s_controle_plane_public_ip_1" {
#   value = module.compute.k3s_controle_plane_public_ip_1
# }

# output "lb_eip" {
#   value = module.load_balancing.lb_eip
# }


# output "db_endpoint" {
#   value = module.database.db_endpoint
# }


# output "db_name" {
#   value = module.database.db_name
# }


# output "preferred_public_subnet_id" {
#   value = module.networking.preferred_public_subnet_id
# }

# output "public_subnets_cidrs" {
#   value = module.networking.public_subnets_cidrs
# }

# output "efs_id" {
#   value = module.storage.efs_id
# }